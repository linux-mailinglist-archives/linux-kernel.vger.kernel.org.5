Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6396C754EC1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGPNMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 09:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPNMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 09:12:46 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82980E64
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 06:12:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-992b66e5affso519473666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689513162; x=1692105162;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=EekKC8PWluAbaV1Pu+9SRWOjoSNHB2u14IM7pM0rkoX5AlC3qd6R1vHHwMA3fYcLFC
         5U143mddL5OG+14KH7JRzc+O6SYaR0yzK0FHy3MUMmBlxNUWms6kBrRLtqj+e2EFGPZj
         2MH8hWE0Z0X/Tw2nQUrQklz+UOsy5mCMqOFkDp+uMtpfX34u/hVYEuc5TLcqhcmpBKba
         Evy81WZhZN3mNz4Rli4WTs9bixquHZdNtIlMozqxSnElO6q8KCkLH+055uP2RS9smXUX
         U49Ee3ppGwHd0PbO3ZsXwEWqSJBIvHZT6pyQ2cTDMNRsnP0IjFeyldyyh7cWz0eP8EmV
         3mUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689513162; x=1692105162;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=Kxkch2wxhTgefnQ3E/LWipBgdxOxQlldt3x3ZLv9Pv7pfGSzYoxZn81jBYiYOmgd0V
         cq5rw3gFrIguJVIy4IW/XAaYrKC5FHnBmJzi0Vs5rhNY+jJ4axnbHpAaqj0wI18Cnkc5
         BbwrBBUgcHGcnVmfgZN9/vZnklkV5SzECBfHUePDVVZXNrdpcGmJKINzHomjBIxzrt3K
         WS80UP6y0tffPVMWX1RX7rllCrH6/Z/7x/SOuKKUG06d+N8dAsHfqIzdUayUWUHYAfa+
         yn887WGMh4wv1uw6dpPt2X/mgleuPRcLqroWWC+j6g4SUJ3ZGtcycjLy8Tg3xpF4WPaL
         ZiCw==
X-Gm-Message-State: ABy/qLYypnRslypRDDajh2xdapZLLZHRZbFygI+2Fpk7P1+70Vr9wWcN
        0yLQOGo5k/R+PY/FSIbkaONG6fwM5bZaATp9z50=
X-Google-Smtp-Source: APBJJlGJe//NqxW6vn9hgDFNfARupvfDdAY46f5dyHvRWDKWVUHcj1pfntJ6eNtwjkvb4ybrj1AA9U+KLR9F7/WjMEI=
X-Received: by 2002:a17:906:5e4b:b0:98d:cd3e:c18f with SMTP id
 b11-20020a1709065e4b00b0098dcd3ec18fmr8171212eju.72.1689513161623; Sun, 16
 Jul 2023 06:12:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:6d26:b0:982:a9d0:917e with HTTP; Sun, 16 Jul 2023
 06:12:39 -0700 (PDT)
Reply-To: dorismartins9000@gmail.com
From:   Doris Martins <possadeliverycompany7654@gmail.com>
Date:   Sun, 16 Jul 2023 05:12:39 -0800
Message-ID: <CAMMX0M6Gx9z=b9nEKqyc6H4MO8LbUFf8KF8TYJx0Uu6KD49YQA@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,
