Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4678A756E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGQUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjGQUfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:35:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E10EE48
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:35:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26314c2be8eso2611120a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689626143; x=1692218143;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGAYQ6rkGNakus8aaZ27EffaPf8koLaE5zk7B3NOHKA=;
        b=fNTJHYvY0k+EqFpPtBcPlOXbiPxg9/WWqqRoMw7xaE5mqE4BgkufqiW1cllr6/UcBs
         pFtRA/Bm9KOkPnUh+wFjRlfwUm7TXb6ifVKmDTO4DqAYsWMdBploLOozxtnJvsLH66TB
         9Siu+NsfUB1KS9I+VFIxEojzmhpb+IofLiLD8CtGHAIt3XeM3o3oTvrdfNEaV3TJM2LV
         jzmxz/fSZ3Lzl5ko74XJ3hukTsXeEIgKKEWAGfxQc0VxWCwqyhBve6/Ofi6VylaQfVSh
         cmXLxLEYXFLeh1PweDWEk13XrDkbQjNXd6caVqnbdx6+jvJAdYqpceNsZUcY1JRZ8T3d
         ENDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689626143; x=1692218143;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGAYQ6rkGNakus8aaZ27EffaPf8koLaE5zk7B3NOHKA=;
        b=JJ3Jg9+uXN3Z44EyZuaN6wXtYAbEX/Xl6s/8nPsv5+Xd5F3jRtlc33SQySpcJM5Bzl
         3OMGezQNCNYfU60jyIfUQud8Iiihza6nuKU5sB/0MZqdzFBYZKx75Flz4hvCJTz6PPQR
         M/xiWjrWgocxeseBI4o2FK5KObSNLxrjLGuqCSiT7hZ0r+iR09EB1K9WIShh5/Axe0Oj
         lETElb69jc0+KPsxM3tu9jMwgkYhUQzZHjEGTuuky7mXOfeSYbUHKFg54T41r7zD0H/n
         piHyLxbiGkuRI79Hj2SodnJclNXhEqfCLYsFEAk2HvRdutrbXmWSBxPrBXSz8sLAVWpa
         ooHA==
X-Gm-Message-State: ABy/qLZQ7AjYoHVt0SKCcgy1KxwhnyU6UKE9M45GU2I2E5gxsYhLqg5m
        8ReenH/fZs84h/tKFIU01WxLPNCSox+dXZ3l10Y=
X-Google-Smtp-Source: APBJJlGSExxWbyI12VcXucP91U7ne99nlQhgRdqVeFMedCA6D4fSo20isdXJM/GT8kGXoE3uru5Vfr43kZysVoqofiI=
X-Received: by 2002:a17:90a:a108:b0:263:5c6a:1956 with SMTP id
 s8-20020a17090aa10800b002635c6a1956mr10404063pjp.25.1689626143534; Mon, 17
 Jul 2023 13:35:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:3253:b0:dc:d560:dc43 with HTTP; Mon, 17 Jul 2023
 13:35:43 -0700 (PDT)
Reply-To: Dr.catherine_chan@hotmail.com
From:   catherine chan <williamsoscar698@gmail.com>
Date:   Mon, 17 Jul 2023 22:35:43 +0200
Message-ID: <CAM8NFUQUL5YjVZiQO03LGH9rDhnspfDMjg6VxZ=+gqgFQkNh0A@mail.gmail.com>
Subject: Re;Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
 Hello! How are you? Please forgive me if my application is not
acceptable by your kind person, I saw your email and I want to talk to
you directly by mail. I would appreciate it if you could send me an
email when you receive it.

Waiting for your prompt response
Greetings,
