Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B17E51A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjKHIGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjKHIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:06:34 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F0F1A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:06:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so5028751a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 00:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699430792; x=1700035592; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=POMvELdGwlx54Bxxz9uHGtLHUn5tvi91FxwAjXx36Pg=;
        b=FjluEZe/e5wmDZ7mYCJEO5Rsjd/kvxyNqdnGJu1NiS9foCTvXpvk6JS7FiqyivE5Er
         AH97+m412GgF+oE2df5AH1x9xrUcwlC03IbANZfzsNN119KPWoCEUvfw3Iwkdjr9exHj
         hVqrMbKpMF2at1OLQ9AwqW/Tjx/iSH+8pV3IERvQh4LTCkLXsmAGkyA3I0DKQ6boI7rV
         TtrnvwULzOSn6V75JmU2DdFvV1dlVRuEZNAhciCFQ+ubuyt2oNC8c8Ver8CCKHJLKHR9
         CXaQ22j60AXbH45pmKUQvtXzpcSw0eJDuk+oluNMQs9hO//cDa8VNlqxnR4W/5UzU3H3
         JGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430792; x=1700035592;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POMvELdGwlx54Bxxz9uHGtLHUn5tvi91FxwAjXx36Pg=;
        b=Tnat4BKdWfbji+dfPLQVaOtihwNWA+dpj75I0O6V9FS+YrOJAW+1ObnvDho0VVewM/
         TJ+KMu5aFG4Xs5cyfF12qIuvG6I3g1tcVAkk3hKNf8Cy9BoV6Kc+QjXGoEIzKNv9rT29
         yc2qKaSF+dcXvee1Bs1Isa3sD5J/WtjoAdeZ1DVDk9M8uIQlW/4mDx+gaYSKGSJFcVy8
         iWa6KdiLrcY5mmOtFaD+yna7smIjLTT50+9pudhljjgd9vZu35K4tTgZnp2qhFcQ3oGq
         pLRxIOIpdaZAB5/eJzotKChREwz2qIauNZ0K7QModD/mhpeSKoMxxESJNOIb+1z9/LVV
         9omw==
X-Gm-Message-State: AOJu0YwyVOw2dV8ndLFVdGvFV/DeT1PwBxVEo+5R5hRwPbSm7Bt4hn0W
        TBcTTrOK9jF3yVKMvC15sYpdbtIQK/xNR7Co3Ts=
X-Google-Smtp-Source: AGHT+IHEjIpf+6VzNWtPNwDWu7kFiDq6/kDblIpgE1lcCqewqQXLUO50Vr2Wxt6DIeRM8qGg+AII+EXaqWGoQbjSVq4=
X-Received: by 2002:a17:90b:380e:b0:281:356:fd03 with SMTP id
 mq14-20020a17090b380e00b002810356fd03mr991038pjb.39.1699430791561; Wed, 08
 Nov 2023 00:06:31 -0800 (PST)
MIME-Version: 1.0
Reply-To: elodieantoine698@yahoo.com
Sender: marianmichel236@gmail.com
Received: by 2002:a05:6a10:1788:b0:51b:e39a:213 with HTTP; Wed, 8 Nov 2023
 00:06:30 -0800 (PST)
From:   Mrs Elodie Antoine <elodieantonie67885@gmail.com>
Date:   Wed, 8 Nov 2023 00:06:30 -0800
X-Google-Sender-Auth: qGNbZ6EcNHXMR9R7AV6q8zI803w
Message-ID: <CAOJar2+i2qfOkgFOkMqYMh63_moQiyaK-DVD2BvtrcPZ-evzuw@mail.gmail.com>
Subject: Calvary Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May God bless you In Jesus name Amen!!!

My name is Mrs Elodie Antoine, a widow suffering from Breast Cancer
and Stroke, which denied me a child as a result, i may not last till
the next two months according to my doctor report.
I'm married to late Jeffrey Antoine, and we were married for many
years without any  child before his death. I'm 58 years old woman.

I have some funds i inherited from my late husband The sum of (US$6.2
Million Dollars) which i needed a very honest and God fearing person
who will claim the funds from the bank and use the funds for work of
God Affairs like; donation in the house of God, propagating the good
news of God and to endeavor God worshiping place and help
less-privileged. I found your profile and i decided to contact you for
the donation work of God.

I will stop here until i hear from you.

Yours sincerely

Mrs Elodie Antoine.
