Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F2D76944D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjGaLMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGaLMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:12:32 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CD1E46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:12:32 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-583d63ca1e9so48514337b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690801951; x=1691406751;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Blv4szNUAFzFHm7hqYLz0B9ikOWx5TKe+P57Nvvs5Ag=;
        b=VjyxSUTgIVcpyd1ZjH4avAZz27gRMBhWtI0KlyVhRwSIF1zIrEbu10vLYROhsaMSJb
         bteVr6PwFbSdn2r6UdISYDhjNy18aThfIBBbwfMi/56IBjBDzqocuEA0jTfhemY8Mpp/
         fLmZAOV15mcHPBJ5T/uN6O2IaAiGVdESZv7zbDqJ/noL00xkBCwoMqBc4GXnC9JOQ2Lf
         ndtGvi/HUD66hYHTxWGXgfyPeqg5nGyb7PRJ2PJM8Nl1Geqt88XBOgL3HGA/p64bj9lr
         koj1s1FEUkinrbnraMiJo09/M6kERn+vmk6ZyHz4rMiFh6mzv5R4oV2ZsG7HY2VpZYlS
         Z/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690801951; x=1691406751;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Blv4szNUAFzFHm7hqYLz0B9ikOWx5TKe+P57Nvvs5Ag=;
        b=FYt4oNb7T/g8egeQO3KeYEYhoNyMHlwagnI6rT9U/9H3MRNEHnq/LBVpaZ4AHILeqV
         WcoJEF8gOAELbZGMOzoAf7WGCbCEKJmpeZp0wWIdPIHDLvqnVuJHWRsIgsM2hJEXndcU
         rCE1kuUv9ZccrI38RZyVYjhjv+MhEFJzJyzfek8fstvlTmLBfG8rRe/7FQlkcaND9Tp+
         TtcNblKrXghh8YvP5XpV3ORYId+PpKei4meN/qcAoo23SBnU5ZAyzmxXz1oYokO912Dj
         S6VBVsQHKFr8yqE4rcnFR4rChjvGk8yFFrqcwVeNgA/hETH2xk5NeLkMtuR1UmKPDVyc
         Gzaw==
X-Gm-Message-State: ABy/qLZ4gfuPUjVXWPrERG+75wfIy37Ox1TtsJSeM40+Dqsr88+jk7sE
        +cOVaH+gsRrwDrpBXtV0GRIZIA7D1f26iTqfAcQ=
X-Google-Smtp-Source: APBJJlHWMfV3MTbgdAcs/QMPrmFFjH0nwdn7PFNYGf5D6X6VikWYWivK3Gr2dx/qeKw2n4IYNdcpd+Y+mpXK02WqAww=
X-Received: by 2002:a25:ad8a:0:b0:d10:17c9:2f0d with SMTP id
 z10-20020a25ad8a000000b00d1017c92f0dmr8877989ybi.2.1690801951364; Mon, 31 Jul
 2023 04:12:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:6583:b0:4fb:b54b:8024 with HTTP; Mon, 31 Jul 2023
 04:12:31 -0700 (PDT)
Reply-To: roroseline7@gmail.com
From:   Roseline Apow <wp372401@gmail.com>
Date:   Mon, 31 Jul 2023 11:12:31 +0000
Message-ID: <CAHxOaVrLoRHCdtKiuqspVT=td2M=FYFVsav_ug1trrK6ymMKPQ@mail.gmail.com>
Subject: Hi dear, greetings to you. My name is Roseline Apow, please, I have
 an urgent matter to discuss with you. I will appreciate your kind help.
 Roseline Apow
To:     roro <roro@inbox.lv>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dear, greetings to you. My name is Roseline Apow, please, I have an
urgent matter to discuss with you. I will appreciate your kind help.


Roseline Apow
