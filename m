Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1D77B7CCD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbjJDKER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjJDKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:04:15 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376E69E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:04:11 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-57b9cb05fa3so390268eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696413850; x=1697018650; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hUJOrwj0rHXyrsp5Gr70njYLzx7aspFKWHqUJqW/WeI=;
        b=dsd3gs4oXB8tt8zGI5h0bhSyQTcAJQOno8x7SnMSgOptpXCwRkQCe0zYfOkfn9rtn6
         GEj/7PTEIObVW6kOx+RVZhsdpJczz2u1bbD46EmC6VVK96Qk/GdiwGz8V7zk8BC58Wbx
         mBHJtoNrNHfQBvS6yM//2IUVUP9sM47U/5IIsDdQtIY1TiraoN0oJa1pDCzUbfybZg1Y
         0YMT72aRP8vvnIb3KsFaCZNxmf5wXNYKzKjwgsO8PB/u9un3OEBT5/0ghjU+IxnLXfZb
         15W8gNRcLD6cf6oFmn8eF4xQbwZgs99tMlgtHZi5LF6VYvFf713w2tH3qZnvXUUDHVq9
         JKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696413850; x=1697018650;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUJOrwj0rHXyrsp5Gr70njYLzx7aspFKWHqUJqW/WeI=;
        b=S1fc60yntS70o00n9L8HJft/+hJ7kkuJtKAqMyIYFQ7OIo9iv27kqb1XYfxin7n+br
         j3rRIpYnF0toQOiFJnMtZKfds1sul7Ww9QBAfZSblwu33zkJFr9RV9AcyHmQiUyHZ8Kl
         voCWL1XOJY3zE94mDr/rgOJ/YRz3RcEAHSxWJyvsWZVMu/r3AH6hSZNzp0K5gex+xIg3
         YmSeLen+09WBL004T/jQtAYYUtWIXtm/7JQZlZRu8Zc8s0k/heeXLB3rNK26avEPwxXc
         n6MmgmOlM5mNKq1M6CgzM5Zvk5wOawKVkNFJJlvlQUlCH/6OSWoJLIPtloGH7/kBrFqc
         ApXQ==
X-Gm-Message-State: AOJu0YyhaNQFvp7t6JArc0VJo2DdePkHoJownBRtd8NMDUlV0JU6fx5M
        kbY1hF6peOV4c9PA/BiQH3ADA1281uYL+QGmKxo=
X-Google-Smtp-Source: AGHT+IHrWHvewZ8jLHJ3nPCCML7AULL1bDuLGKDJfuxrl1uK2GrCmFFmvy3PYbY8WJ2LWI32K1rJsCruWnok4LNTSO0=
X-Received: by 2002:a05:6870:d204:b0:1bf:42a8:2cd2 with SMTP id
 g4-20020a056870d20400b001bf42a82cd2mr2930663oac.25.1696413848675; Wed, 04 Oct
 2023 03:04:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:f19:b0:13f:411:c1a2 with HTTP; Wed, 4 Oct 2023
 03:04:08 -0700 (PDT)
From:   "Unioil Petroleum Philippines, Inc." <shivrajkathpalia1@gmail.com>
Date:   Wed, 4 Oct 2023 11:04:08 +0100
Message-ID: <CAL5hCVy6BrHegRU1F7fDgg6A9UXr6AD4NCsVzMJQmsZCWWABAA@mail.gmail.com>
Subject: New Order
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings

Please can you connect us to your sales department or send us your
latest catalog so we can place an order from your company

Thanks, and best regards.
Purchase Manager
Mr. Shiv Raj Kathpalia
Unioil Petroleum Philippines, Inc
