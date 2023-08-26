Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD944789731
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjHZOIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjHZOIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:08:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEBC2683
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 07:07:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-4ff9abf18f9so2853441e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693058835; x=1693663635;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2RQNoxb2JU5kGe9U2HivLjm+aU1Pl42n1ug1iZISgwY=;
        b=fwnPSnBhF2J7cJrPZv7ZLWJOCtD4VG/Hx99EGyKJB/lOHHlGPsxe+pES9FFPHk/TWF
         CL2p7jDpiJ9v3Kr5m1oU7DImBjL6b9fjQD8PSwRzmpm4Ryn2r8/Hdheh1yidKT/AMUzn
         WXVav7hZTdQB0SYWOTTtrOL6g9hINEc/yHtf6WDhlwuwQGVlKnTr1+TlyjCz84dwrG4J
         xULQp98kaoTwk4pyP7/FKZgBFY1MWOwcghY5nKGT7Zr0laav25v0M+jfQaZq/mG0DD0a
         oxFGojnXhMYtcEhBzu0nwB6ivJ0qnc5gofulFmqFN4kcLzLaX9eD6jes0jRk+DZ4K9or
         Wmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693058835; x=1693663635;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RQNoxb2JU5kGe9U2HivLjm+aU1Pl42n1ug1iZISgwY=;
        b=cZMfzM9tehoXGgV31yESsxHDwxCThfBjkZ9DCMOHeOYam/M8+OpqBXliIXrhTx3alc
         NRczm/LpRRLxpcTZ2QD5eI3h7yrOqZocKVe5N/bR9uuE0CRe+c3zi2AEEHUIyHkbtl2z
         YfX3siMUs7LVYnSpZRNp2XALDig2iR0k/xMMPpO0g88ym1uLeog0Jls1RMalWokNjDr5
         MORQ3D7McnM1jKlzuvPI1l4g45VisFdtYmNUIwnbZWsRlkSL44KvFMe5+IY8fT4lPjA9
         8aH9BIceyHRsjH3x7tWQtC8J6/5YawcgXpjRjUwfJTa1B40+KIDyCG6So1fNRGaZz/HU
         QC2g==
X-Gm-Message-State: AOJu0YxfHEcHHiw9FedD5cDI9fm7fFPXhgcommriU6uuDdlx6+aG+VGP
        0y5t8xfKvWqR7/9DMV2QYZO6R1RbMdGh80RaNIY=
X-Google-Smtp-Source: AGHT+IEMkWvlO1BSqL2m5T6TsShy4LVe+p6dyDAfEndAnuTRfMxijuzm23UNZlAPdVTUjjkuQkQJ29BBmYgYezoTKz0=
X-Received: by 2002:a05:6512:aca:b0:500:9f7b:e6a4 with SMTP id
 n10-20020a0565120aca00b005009f7be6a4mr7051213lfu.32.1693058834359; Sat, 26
 Aug 2023 07:07:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6400:5710:b0:22f:7e4f:372f with HTTP; Sat, 26 Aug 2023
 07:07:13 -0700 (PDT)
Reply-To: jennifermbaya01@gmail.com
From:   "Mrs.Jennifer Mbaya" <fandjinoudonatien@gmail.com>
Date:   Sat, 26 Aug 2023 15:07:13 +0100
Message-ID: <CAApPn2p4izVyixVH=xkdCx2u+rLTmTdSrbQvF7ztN6uebZ9Urw@mail.gmail.com>
Subject: Beneficiaria
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beneficiaria
Usted surgi=C3=B3 con un premio de las Naciones Unidas afiliado a la
fondo monetario internacional en el que se encontraban su direcci=C3=B3n de
correo electr=C3=B3nico y su fondo
liberado a nosotros para su transferencia, as=C3=AD que env=C3=ADe sus dato=
s
para su transferencia.

Se nos indic=C3=B3 que transfiri=C3=A9ramos todas las transacciones pendien=
tes
dentro de los pr=C3=B3ximos
48hr o ya recibiste tu fondo, si no cumples de inmediato. Nota:
necesitamos su respuesta urgente, este no es uno de esos estafadores de int=
ernet
por ah=C3=AD, es alivio de COVID-19.
