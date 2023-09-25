Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C457ACF70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjIYFXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjIYFXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:23:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094B7DA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 22:23:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-277191ba647so831336a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 22:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695619396; x=1696224196; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=W3wjgaiSIz61Ec4BqZm3F2oCKKxQ16pYZUWrqcKiqh85SrbIev7TlnY7yY5Wo/uRom
         t+K4B3Nd3VOQ+zvvHtCA5CLsPfV3AizKTaz9gvrQ5CCG6Ou5zmwp41mWfMa4sdcONkCE
         6tdpoG5F3o0fNAkT9Rj/EtMP0FqEi2sxFhhoI9ej9sIqFudNPwruPGmmeTXr7XXvNLZN
         iHT9qbsh9isPj9aWZuX/+USCQRtxjgwTuvA+EjueD+CkXKcOI3Jhk6pNwSB19K3PTh1e
         Vr6ga1Zi/v6UvymJ+f2DB+aWCjOuQxobPWVoT8OHNxLvUYZuLjJOBmikqkkKlj9tqYfj
         AvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695619396; x=1696224196;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=UUJUaU5xJEsfdhlzhJzLvXk0ufbq29lb5GdGQerQqBUAxbjhbqJzmzlhzUdHNinRIm
         CNwvMZd21qvpZUg0ct9NHB/q7mse63hH9oEry2c1BZnAdShQzqE7fykHjAjpDdFJTFHo
         +xP/RqjsOa5KpS+nWmBy3U4Uk/rXJUXzlaxQmTC6jkGR3E9XjJsUjyO2nubZaCSasVot
         7Qe5zxAex+6gomGLz78ZBhgTm61OOBjZ7eOXcvhtjQ6HcuZQNqZ2kgU1WQRVH3NRHvw1
         T4obqs5GmqpgpeIDNzHulsi+f65XEMsUZ5l/mt017zxHTEiJSY6pfWpjGnoCyxU3jjDK
         ocjg==
X-Gm-Message-State: AOJu0Ywox06zjk+C0R7schA6+z31NFQPTANyMFJHQUHoOmgUtQuurS0O
        Rs8u155VnW3iG/aor7qpW3ejzVQdOdH4KtWgJFY=
X-Google-Smtp-Source: AGHT+IFJv3GkUKeHuUHZb0pu9SnepY4djqpv9mIbAnWr8Y2O5dsHPD9Fnb2/QlnEeC5zlDn3Fm9xUeKIfRQ9Bn8R/t4=
X-Received: by 2002:a17:90a:3046:b0:26d:1eff:619f with SMTP id
 q6-20020a17090a304600b0026d1eff619fmr4931962pjl.2.1695619396445; Sun, 24 Sep
 2023 22:23:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:548e:b0:134:249f:42e4 with HTTP; Sun, 24 Sep 2023
 22:23:16 -0700 (PDT)
Reply-To: dorismartins9000@gmail.com
From:   Doris Martins <robinsonlori989@gmail.com>
Date:   Sun, 24 Sep 2023 22:23:16 -0700
Message-ID: <CANi+hepN4Hp2prpBJzZ=hmvnqmcRK0ix8rVSBdNVWUq9E7_goA@mail.gmail.com>
Subject: Greetings
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

Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,
