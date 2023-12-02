Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B912801C76
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 12:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjLBLeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 06:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjLBLeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 06:34:08 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CC0D67
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 03:34:14 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so1079935a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 03:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701516853; x=1702121653; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BcALMsPfNzRut75iAMiTa+35IbfOiL0hIFJs7tJe3x4=;
        b=SD4CYZPa9ZqMgmGth4xYf+WG91A/ktmOJi/gKLWX4qUcZr1HGkcEAfJI2gklcIVHok
         1Uh6TUhwxlVYgeqzberY1n9tMoL9zk9pO8BCEJYQO18d9YL+c7Z8qlVfbTmqY66+btPX
         YGfIuGvK2p6yHVwkkRXUKZ4ZF+RPz96QqvtTusmUKK6MmX6RoexY1gUs1832UT5/VnqU
         /EQoFWLWaTLLQZP7LERjisWR6kHRy1duRJvbQa+PppEinYQ89mXxZFM8QBWmeZ/6ljCw
         j1NBH8Mehrv57Mqja4ryikgtvScEM0BQohzA6bEyZfL/TOTLBr9DmJjz+G/x+XqtPJv+
         U4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701516853; x=1702121653;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcALMsPfNzRut75iAMiTa+35IbfOiL0hIFJs7tJe3x4=;
        b=rLx5pe7O0KUK0VduKgRHJtgwsWAKwTi8YruBe8vTmkuZBFOv/Dyp9Amq15qAqLOfwz
         h6ffLQqnw8R4lRxHi0XHXZC/1sWHTUJuMkXIYoH0tRU5VOPTPLYU6/wvIystNN2Lbizu
         smmB7N5z4KOIj4+p+HYzd1j+cBikfoAFf3jzAlVw30Thyue61wXtmlnJmXSe2Ye4U8sA
         ZiUqPgq5wywkhbHfX1KKIbMTBacPzbUp+xkeZFw+pidmHwY4BZk3PRwzpmknC8OiYxSU
         /s5UOUbTnl8rIFEjLUR4cAVXa33gEsbo4mPJWOuQcpg19Rv+Y1TuBHK4XelePFbxyswz
         ATEg==
X-Gm-Message-State: AOJu0YyfVAvWMhuDVzhveef7/9z8zaF7YQSZZC7C4LipiWW2ScQofakz
        ODEchWd0iBWsiDLmDGvCz9dPWZEEzbCl/hhQEH0=
X-Google-Smtp-Source: AGHT+IF5Tx27jw6MdCkd1AP+44E3UmcGN/9U0mozEYBzwGjwO9TqQV9XJ7RVZTpuUJWtUCRdpC9jzXpS+51NmrB9J6Q=
X-Received: by 2002:a17:902:b416:b0:1cc:6cc3:d9eb with SMTP id
 x22-20020a170902b41600b001cc6cc3d9ebmr915607plr.68.1701516853629; Sat, 02 Dec
 2023 03:34:13 -0800 (PST)
MIME-Version: 1.0
Sender: nwekechuma83@gmail.com
Received: by 2002:a05:6a10:2a15:b0:4f9:5349:a6d9 with HTTP; Sat, 2 Dec 2023
 03:34:13 -0800 (PST)
From:   mrs jenniferabas <mrsjenniferabas@gmail.com>
Date:   Sat, 2 Dec 2023 00:34:13 -1100
X-Google-Sender-Auth: 1ZajntLtiZ6WoUTtXFalz_FWjrA
Message-ID: <CAC7bnj5Qr7S=n8AZapfeMPArf1y8k42upsx9TVS5Yr=qtZdnaQ@mail.gmail.com>
Subject: God dag,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,
        MONEY_NOHTML,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:52d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsjenniferabas[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nwekechuma83[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  1.7 MONEY_NOHTML Lots of money in plain text
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

God dag,

Jag vet att det h=C3=A4r brevet kan tr=C3=A4ffa dig mycket =C3=B6verraskand=
e. Men det =C3=A4r bara
Mitt akuta behov av en utl=C3=A4ndsk partner. Jag skulle vilja veta om dett=
a
f=C3=B6rslag skulle vara anv=C3=A4ndbart f=C3=B6r ditt godk=C3=A4nnande. Ja=
g beh=C3=B6ver din
uppriktiga hj=C3=A4lp
f=C3=B6r att f=C3=B6rverkliga mitt humanit=C3=A4ra projekt. Tyv=C3=A4rr =C3=
=A4r jag d=C3=B6dssjuk
och p=C3=A5 v=C3=A4g att d=C3=B6. Jag vill att du ska spendera pengar
Mitt arv =C3=A4r tre miljoner etthundrafemtiotusen dollar
($3 150 000,00) f=C3=B6r v=C3=A4lg=C3=B6renhet i ditt land n=C3=A4r du tar =
emot
pengar. Det skulle vara ett n=C3=B6je att avsluta detta projekt med dig inn=
an jag
d=C3=B6.
Mer information kommer att ges till dig n=C3=A4r du svarar p=C3=A5 mitt f=
=C3=B6rslag.
Ditt positiva svar kommer att uppskattas.
(mrs.jenniferabas@gmail.com)


Din syster,
fru jenniferabas,
