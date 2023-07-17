Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5DE755FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGQJ7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGQJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:59:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDFE194
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:59:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-263374f2f17so2198265a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689587988; x=1692179988;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaUgBVDv8XJC9KwT1nYw3VO0329gUyssPKGDQaCxM90=;
        b=iC/D6ZsM38CS6miHODbMpdoodSLBiKdD7KtTbanYvras/ceEuqaveWZvI93Z5mFaaM
         8UM/AdxLG+mJTTfZ0SaO0ShyUqBpHMaG5+aRjnXio/wujWip+lyO1CEuk2/a2dA4dUlc
         /taS6xA1JKson2VMIa95pBSRlMboFePHD/qMXvlzvdhCPQAKo3uPFsTMKHprHUpsNAf5
         94HLcrGSNmqIfLb1brvHyqh52EjnKgA7g5u2EQN21NBxH4dUUmZEvgI/2aURpsyeyQl2
         q+CytRr7CMONSGEkoWqBwlX0awMy00wZhUkOYXK9GxzgFlmi6uzGaah7crhUIaKmNY3v
         AkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689587988; x=1692179988;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaUgBVDv8XJC9KwT1nYw3VO0329gUyssPKGDQaCxM90=;
        b=Bwd5BAgzYgKkb6IA1sE1SSX35N7AURNnyomzmTNLmw7Bd+OP5+W6EZNhEJ1Q109+R4
         mCrECMNq9DNHK+RIGqXoFeYImhijR9DVR6gUf/pdpaEXwMYnDf8wcIl3hjQlfnAVYRYw
         5G5J5t8wPTlhINplAL7g/kDQCelVLosS24nYejL31st/J4o2+/hAna7S7rniBSEWFi3k
         6ipHxF4w1227IFEtYvSfAWsE/cjy991zaIZiuSh0yVuJdea4uPJu/SjhZ9ckL4DU+d0m
         o97iszk/KaAFtgbJgDl7eNX1FvQ7z94V0uTfKXIvGrXQ/5VzOA0x4cKIn+8nSv2pNulw
         +e6Q==
X-Gm-Message-State: ABy/qLaT76MgndG+elD63X9PFBVytsbl1L0YJ9eCNXc14u8nQXxkOWOS
        m+KSd+OooP40F8U8u8Y86ZGyyj5KjfmIgOzLYWw=
X-Google-Smtp-Source: APBJJlG3JzoNOLnsFn6mtfJA0Lw+YP9SC4OnUQSjkqUL0Rt4d/Z9PlTIgl3mOwRmKYL55olK0njRIVk45wvRnGdeHC4=
X-Received: by 2002:a17:90a:e38e:b0:25c:1397:3c0b with SMTP id
 b14-20020a17090ae38e00b0025c13973c0bmr9283321pjz.37.1689587987721; Mon, 17
 Jul 2023 02:59:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8c07:b0:4d9:6458:66e8 with HTTP; Mon, 17 Jul 2023
 02:59:47 -0700 (PDT)
Reply-To: zongokatyh@gmail.com
From:   kathryn zongo <westafricafundrecovery@gmail.com>
Date:   Mon, 17 Jul 2023 09:59:47 +0000
Message-ID: <CAOT=_FyGMD8y1kp6bbiHxanqUWmOP-DGwJHXzvdDNZ17_KjuDQ@mail.gmail.com>
Subject: For your kind consideration!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,

Nice to meet you, i am miss katyh zongo, very sorry for the informal
manner in which this letter is reaching you as it was necessitated by
my urgent need to get your response. I came across your email from my
personal search and I decided to contact you and I've something very
important which I would like to discuss with you and I would
appreciate if you respond back to me through this my email address as
to tell you more about me with my photos, my private email is as
follows (zongokatyh@gmail.com)

Thanks
Miss katyh zongo
