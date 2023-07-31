Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7FF76A0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjGaTSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjGaTR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:17:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D80198
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:17:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26837895fbbso3582056a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690831075; x=1691435875;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGAYQ6rkGNakus8aaZ27EffaPf8koLaE5zk7B3NOHKA=;
        b=qrJY0Klv+4UzTgq2qYvXPy0Gu8GFrnOBl6OuqmHfe58+FxcoISbPqN83EVQR5HcLep
         yn0KBsNNUg665ksTDv4vw8YcLtYvkvQ5t/rq+ybBRdoT0esVyMxL/8S20egk5pgZRhNU
         FD91NiVFDrK8T71qFQPypzva3n2Qz6X4h4mN7hFkyWnNUvahmSgaANHdxlAWqvDuUpOQ
         OHyPO/g0MrQfKZXJ08ahYpwf2zX3ZP4OAKd9XwDl2wJzsE1LSiT9ikl5GKxtKuGUtG7F
         H/bnuGRntBakaGlF1tri8f7aM56TQRBRJjioWO0Zti6vBkYDji1nTwvMoqXXMwmHT3Am
         Y6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690831075; x=1691435875;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGAYQ6rkGNakus8aaZ27EffaPf8koLaE5zk7B3NOHKA=;
        b=bUvp443EnrvZnH1t7ETTYbEVCHsI3gKCQ8xZxv5EPyMmn6EsDwnNcuWhe/XAcPg9r1
         cu4Jz0NZKXHaFZ+9GKuOKZdraibb52GZX9iDpcMTWKelnSWG1UTXq3Lq3zcf4w3doViZ
         CVi1GO+bN4rg+6ZH4kurlXeCpk/pcC9JKRpCgWweZRcstKA/8zXOVCA1vv4qMaVolRwt
         RNDDjlfNEfu68EHfrjf4jEf6dgVgGOuRQRUZO5VBn0bwfXEOxrgpaWilQ1rUuoYDi8Qs
         6Ivib+Uz6MNW2nmC58c4HuZZsdspAQl48ZFWJPidLx2ba46jurLnApphKjWsJdfGl1Do
         vWFA==
X-Gm-Message-State: ABy/qLbzL6odWhIdFAvKRxphQcWHJroopg4y98y5hyWGeiYbaE0Yzrmq
        fUMMCipqGk8Bi5S4d4Am7F1VRyT84G+0hfvrtek=
X-Google-Smtp-Source: APBJJlHUmRwgZuBFyJqq72afSFC17MG7jYOYutm75qVNi3iKrzt5R33otMmJajGFL0kyeyJXsU+5PippGX+BAAB3+2k=
X-Received: by 2002:a17:90a:6b84:b0:268:5477:811c with SMTP id
 w4-20020a17090a6b8400b002685477811cmr10799436pjj.23.1690831075200; Mon, 31
 Jul 2023 12:17:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7301:370f:b0:d3:5d2d:c3e7 with HTTP; Mon, 31 Jul 2023
 12:17:54 -0700 (PDT)
Reply-To: Dr.catherine_chan@hotmail.com
From:   catherine chan <michaelgere001@gmail.com>
Date:   Mon, 31 Jul 2023 21:17:54 +0200
Message-ID: <CAHXSnz-5zvKitiwRBj-g+ezDFpSW=LtsXAQ7gdLYFahwcSqFmg@mail.gmail.com>
Subject: Re:Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
