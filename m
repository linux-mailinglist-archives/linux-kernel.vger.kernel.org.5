Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA967F1126
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjKTLBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjKTLBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:01:11 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CF7C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:01:07 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-408423fc784so2185975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478066; x=1701082866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VRGPYlejlgRW8D8NHHDFM+md1tYFSzw7yM0bJwcPBcKtcJew0Nt4U4NW+q3EQkTtAr
         0kg6YkoNeYSCXQi9tMqCOBVi4Pfnw3EASyWVJ9Uj3udPbEmbjGeUqmWtuHDyuq1bSOVo
         vqnrqJzeEYPY6lZSdVUsVhw+pn6Bwese7pGKfoOp+BWzdTJgMfxZ5gvSB7hCOEIY75eT
         boxo+CFQS/CTdFtsLyKb28t0GC86eI4eo0o+Z7emxIAM3ifzhw37DLpos92bRfY6TVhb
         lRIYTuwUOrl49q+1/MhfAXOKVuycwBjg6epVdeAdOQcItZmrgn5tFIv+As7FCgevivUs
         bzIg==
X-Gm-Message-State: AOJu0Yw5CBvlEK8iA6/O0Y7DGAoKEaplGG5uUuMkE4tK+4j9Rn+vhgZq
        +3+fWaU0RVCVCqO58osUueUySIafraA=
X-Google-Smtp-Source: AGHT+IGhlldqDixGyGllvnolSag0cu3gFPwbWA1e4u9fC5SdAdWMJO1V1YinqrYKHdrIj54JFTR4DQ==
X-Received: by 2002:a05:600c:4e41:b0:404:7606:a871 with SMTP id e1-20020a05600c4e4100b004047606a871mr5977827wmq.2.1700478066190;
        Mon, 20 Nov 2023 03:01:06 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b004094e565e71sm13041848wmo.23.2023.11.20.03.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 03:01:05 -0800 (PST)
Message-ID: <550c6580-bc39-42ac-ac19-230f54a6e10c@grimberg.me>
Date:   Mon, 20 Nov 2023 13:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 RESEND] nvme-auth: set explanation code for failure2
 msgs
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
        kbusch@kernel.org, hare@suse.de
References: <20231011084512.1835614-1-shiftee@posteo.net>
 <20231011084512.1835614-2-shiftee@posteo.net>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231011084512.1835614-2-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
