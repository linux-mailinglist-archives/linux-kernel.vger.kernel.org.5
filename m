Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB854792D47
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbjIESQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjIESQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:16:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAD34EE4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:12:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-56f84dd2079so1368167a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693937472; x=1694542272; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2ElIG4cWVmacCIoreYp+Xfp1/rhUdGXJUDUCDYGnb4=;
        b=UvMlSDjyqkmPN1mDYAjEyMyMEmeZmnZGDI1/U9/3F+0aS12wmmjtjnnoqr/iuBLwGS
         5m5dPK8p7/mH6mgKEuzliYjLbnGqxsQOYISNuMEoVHyR8+4y4shOt2bBENqOBaSe9Qec
         1UIVeY3nvDZcVtqV89nXWj7ICP0tWZwAZUKzLE1sp4F0i54aOZDdJAjUiKcnQtWfaI+Q
         eeDTQaInLpXfKKrmeJBqubOABmAYnMKM2mWJlEfHexAEJqd7Rd8DJRIm4dvHGcrSJ1Zy
         gTmWOmzpJEO8/FdfeJ8Yrcob13rtQHl2sJFhmfwn6w0BH1XN/vLQwMhTWBf4iUrMLQAq
         h5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693937472; x=1694542272;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2ElIG4cWVmacCIoreYp+Xfp1/rhUdGXJUDUCDYGnb4=;
        b=XlATQ5IjouLZSRvA47fU6ItDS2F30DKKv+Re6dRCjASJqGv81ZOTRQDCG+uCIQnLog
         UQ4hQt3ED5LWngSIX2m89JlOAN5/STC6ozbQGg15GKYxx5mVsgi+JHUAIV2uarzhORX+
         DACpceQUrty46DjEx7UXEhl64bN2WfM1/hcTUAyJdBa/A7Hpnez8znAUFKfsM4cyb/ff
         mHPMqGAy5y7dgSnfWz4tUg7FEYqz7n5I6XKzfCY8CCm8+uf0DCJaJ74jHEXk2dlOGjgC
         0NpSjJSk0h/ZP4Pg+w5X8MZ8vDNQG/b5LfkGWkYCXP/9wRnuwV/ypK2KnDlJX9znGmvg
         nn4w==
X-Gm-Message-State: AOJu0YwLCmSF7p8VIwP+GyC7V54Ww5VMgZ8VnaMXzfTnr7yhJ4EamToH
        mT35lDqyNrXjxcKXsDCCP6y50B02dDP/Dvr2jJI=
X-Google-Smtp-Source: AGHT+IG9Y+3JbJWQqF4BbkPyxKUQBAVHVOOKnfactdy7j8dnBimtSxHybw0HBA077BvU4eNi3gR7W2hQm+61uhJGSos=
X-Received: by 2002:a17:90a:ac10:b0:267:f094:afcf with SMTP id
 o16-20020a17090aac1000b00267f094afcfmr11055277pjq.12.1693937471719; Tue, 05
 Sep 2023 11:11:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:730d:b0:d7:3976:e069 with HTTP; Tue, 5 Sep 2023
 11:11:10 -0700 (PDT)
Reply-To: sritterhouse052@gmail.com
From:   Sarah Ritterhouse <sgt.monica335@gmail.com>
Date:   Tue, 5 Sep 2023 11:11:10 -0700
Message-ID: <CAErAGnr0_z-18Tvcjf0Ly20acXzW+whXwwZ0vKwAiGvj4gxx5A@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,my name is Sarah Ritterhouse.

How are you?, I am contacting you because I have something very
important to share with you,write back to enable me to tell you more
about myself.

Best regard,
Sarah Ritterhouse
