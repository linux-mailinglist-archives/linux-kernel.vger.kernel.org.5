Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9A17929FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjIEQdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354809AbjIEOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:34:59 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41524189
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:34:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1c0d0bf18d7so13939275ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693924496; x=1694529296; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WH4KPNvpExuebEfEFKJW474DWiLQXb1PwRRTvT2Va2A=;
        b=PzELGMMYWfjLWGYAOgRLR7EJDvFiidDO+oNhkumtqSa4iO3JzPHf+3x02+nX/chZ+1
         l67Cei5FJSryYvEbVYwG2+r+TOMEvIqQEuV+52Rf+l5JhtfwN4PhvBJEf5eX0fsnpWIg
         SYX9oykkq6zNdgoB6sErX9eBPXejUIe7zmE0NTTypD15dMoYuenQJ8pFLUSI6rqhwns0
         llW7DvBx9WKAWtQjKHgd/RiE8VAm8VXSFHNYS9uQuaYhGIfEtQ9UubTsjZ0+HtcSXh2d
         DZUgX+uoPwspsc44O6Q6h5YKL0xphSM7UvRLyCI7GrpJZhXOfx5fFMGgWY6fR5oCXe4B
         FziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693924496; x=1694529296;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WH4KPNvpExuebEfEFKJW474DWiLQXb1PwRRTvT2Va2A=;
        b=k0pkyBBgu/J+Gn1y+aZYLTYLMmQjmMCqBP6N89429gdW6SunJcFiJ7sxpfRheIRfaV
         YHr/Y+Qx3Aagp0D3q56gTqo87LDie4sr6rMqmY+Qmv/eXgvgKybBCFnk65EbntdExJ/Q
         iKVjqQ+8s6j110jHJaGIdmWFSnjWPCvpddkZzAc8vIcYXHZUZMBSz41bUCKxmD95yZKc
         K3Kw62OmTh3Od5lSHwQmCWzTvLwwFeknurxJnOxC4E+knQa0q3hn6LsmfCp00pFSK51b
         Y6s70hUttLVRRCas7Jl0j9lv04Hef3yv+YE0A73j5TCXZ8yZORTxUsKjSIVJQcNIGXbo
         4VJA==
X-Gm-Message-State: AOJu0YyxM5VRWrXbeap2RT0jJTTpZIq/PMwtuZzozMs1oUkZGhrSTV5C
        pC5RPknNBR0FNyE7Ya2bu7qKnelySQplsPy4YcY=
X-Google-Smtp-Source: AGHT+IE0yR52xfFj1nL5+Zzxbl8GlyBQMdA2SnHrWiBaN75F5dVxMTchAykjEF0W9oEKqcKCTG8DVRyoclivliiNl3k=
X-Received: by 2002:a17:902:e5cf:b0:1bc:8c6c:217d with SMTP id
 u15-20020a170902e5cf00b001bc8c6c217dmr12504572plf.61.1693924495458; Tue, 05
 Sep 2023 07:34:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:e9cc:b0:1be:f37f:a8c8 with HTTP; Tue, 5 Sep 2023
 07:34:54 -0700 (PDT)
From:   Miss Alice Aaget <g3511172@gmail.com>
Date:   Tue, 5 Sep 2023 20:04:54 +0530
Message-ID: <CAErukXkbAeQciLSr9sFNCAjq15XpDWtjxU50Xi8wdW_9EEvPnA@mail.gmail.com>
Subject: thank you for your time and looking forward to your response if you
 are interested
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Sorry for intruding into your privacy
I am Miss Alice Aaget

I got your contact email from the international business directorate
and I decided to let you know about the lucrative business
opportunity of supplying a raw material to the company
where I work as a staff,
I am an employee to a multi international company.

we use a certain raw material in our pharmaceutical firm
for the manufacture of animal vaccines and many more.

My intention is to give you the contact information of the
local manufacturer of this raw material in India and every
detail regarding how to supply the material to my company
if you're interested, my company can pay in advance for this
material.

Due to some reasons, which I will explain in my next email,
I cannot procure this material and supply it to my company
myself due to the fact that I am a staff in the company.

Please get back to me as soon as possible
for further detail if you are interested.

Thanks, and regards
Alice
