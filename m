Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E487876C82F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjHBIQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjHBIQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:16:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A24E48
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:16:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe426521adso3006071e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690964161; x=1691568961;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1XKoPsX4UORhornaX2uleS8Riwv7Wf5fxSpfuXgQDg=;
        b=bSPZ7yq66wj72cC1huv59PJSPMCMW0dzLNUr9gtAgTH716mcEjiGsA7MSHGy7BeEPa
         TmP3PIn3t30vy99dEr+yicUF/73mKAoNzZMeMCfL8cSi178AN1CXbTtRauv7ULdWFZrz
         LmA2Of7N0X2j4qGi1vfqwWJwLeBmYpTILy4sy82Ue7W6amK4JhJcp1CiEjP4HCwL7kSZ
         h2ur3EDYTpROkntjwxuBGCMSCQ/pnaVUZFFJ76hzsFeAoz+HktTv4UC5H9mPUSLS25EK
         JY65jXjNAIiC2on+tt1rSyw3c9HpYJYiehZvCNZkVsKbb8zHK4jgj5WHo7EyDGirgas2
         ih5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690964161; x=1691568961;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1XKoPsX4UORhornaX2uleS8Riwv7Wf5fxSpfuXgQDg=;
        b=dB8x82xs2TGk0eZJbHKJS+LFUvX21LXL+tpsSVAyT+mOa4vA0w2IY3h0f4tLgIGnHV
         VftK4T+3g3edqYofJzZDsCWh+GleuMvGWyvqZgKsMkVkswT02m5a0LU3T+W+B6e11fWX
         5VhC8k/dZ8StYaq//ENTMx1qElBK6LgZvGZjuiZH7/6BIuri6w09oNWf0z61eZsBrfQX
         0GehDaPm73J6tuWMp3X76QTVnfRRy7GLIwG7yogHSbvAKhtBMF9X22shs/2PNhx/cJzN
         jzoKWVhHuMB7rd+VeR8fFz+Yv90vGsEbjVfT6WgU3r6ztLEXvZwn9+p3papaSMV4afQk
         hXkw==
X-Gm-Message-State: ABy/qLZ4eChd4OBupenA3h2a7GlrLNi26fylxxV+p7PPvSKG6XWOkmS9
        2CxLt8Uhxg/VubQugfNK43JizOfpCwAoZWDumVg=
X-Google-Smtp-Source: APBJJlG/YxjoODCy9ypi3OF65XEByNJ855BHvG5T7TdSod2dOKX/4abZA9xLKadj3kKvf9eUn6ltsNTh974Qu0vpuUE=
X-Received: by 2002:a19:e612:0:b0:4fe:788:d969 with SMTP id
 d18-20020a19e612000000b004fe0788d969mr3849360lfh.69.1690964160962; Wed, 02
 Aug 2023 01:16:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:7814:0:b0:239:e92:2871 with HTTP; Wed, 2 Aug 2023
 01:16:00 -0700 (PDT)
Reply-To: carolynclarke214@gmail.com
From:   Carolyn Clarke <crftpedals@gmail.com>
Date:   Wed, 2 Aug 2023 10:16:00 +0200
Message-ID: <CAGoVmOr3F5GQdgn+Xxu90WMn8-hBzYSqeK6Sf+PBksgQi-SMxw@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

Kindly reply back urgently if this email is the most effective way to
communicate with you, I've a proposal that is in your name,

Carolyn Clarke.
