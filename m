Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4397A14A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjIOEGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIOEGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:06:46 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21EF268E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:06:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fc292de9dso1293264b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694750801; x=1695355601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQIsZqq3r3Zimq29GtnYDFvUT1Y5EpxFhWTor5l0Hrc=;
        b=E3BJB/yaFf+864/VWwWrS9ckniqsFKnRpymLX7L/A66jdq6ClTm+Apkbs6YeIQHcJe
         8rTyDat/2A/k+ZQcHiZyWqgpE43XKZ8a+t+w4VvKE0e+NJDiTfSsehDEyImwO5cXv5ed
         RVDK0togBgmh+XDJw7Y0dutklbyC6cr4qQWV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694750801; x=1695355601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQIsZqq3r3Zimq29GtnYDFvUT1Y5EpxFhWTor5l0Hrc=;
        b=SI1Z9XXrRpDKo8uoOmIxj0RvuzVWe8u/JjwS97FLjg5tGGn/Qdebr37t9f1+7ngLC1
         HNHHAQH2rbg6zoY6B1V8CcsM2gT5q41oUlb7AcuhhsjJJOzAYrMBtShnFuXBvBp9fKGm
         wF3iMf9RUZhi3ANmm8hlB3JHnfOj+g33eWLUZ5ZYBCgB7fb0am6yv25bzmUR9wcvvI+U
         mP9oYcyDRLS/M8oE7x6WL/F83Va4UXT2v3D56g3oaH9OVMT6VNsHYilKtPAcuIJUqbUK
         kP5toJI+5b+xDEldAvFLIIJAQGPu11PN+e3M5w65m/yREC1t3cbX0CfKfAhf3eTjsTS4
         oYpQ==
X-Gm-Message-State: AOJu0Yx2S9XxOLDHnyZpc/mm7DP2Tdf8FG0fia1k2xI0PHjAhgvGEovk
        fB2eCK9yNnaXIfv80Tw8ukPjVm3LU+2Q140qIT8=
X-Google-Smtp-Source: AGHT+IGuaifRN1MA4zEcfENV+4ujMa+RMJJy4arIby8+XPbF2C8/WtABlM6QhpCqGq5O5/UkctFfmA==
X-Received: by 2002:aa7:88d3:0:b0:68e:3616:604a with SMTP id k19-20020aa788d3000000b0068e3616604amr951648pff.8.1694750801309;
        Thu, 14 Sep 2023 21:06:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78e10000000b00682669dc19bsm2029962pfr.201.2023.09.14.21.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:06:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     tony.luck@intel.com, gpiccoli@igalia.com, corbet@lwn.net,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: pstore-blk.rst: use "about" as a preposition after "care"
Date:   Thu, 14 Sep 2023 21:06:35 -0700
Message-Id: <169475079278.4074005.13277310628127436938.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914133729.1956907-1-tudor.ambarus@linaro.org>
References: <20230914133729.1956907-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 13:37:28 +0000, Tudor Ambarus wrote:
> Reword the sentence to "care about the {oops/panic, pmsg, console} log."
> 
> 

Applied to for-next/pstore, thanks!

[1/2] docs: pstore-blk.rst: use "about" as a preposition after "care"
      https://git.kernel.org/kees/c/a321a540e3c9
[2/2] docs: pstore-blk.rst: fix typo, s/console/ftrace
      https://git.kernel.org/kees/c/cb3415405a9b

Take care,

-- 
Kees Cook

