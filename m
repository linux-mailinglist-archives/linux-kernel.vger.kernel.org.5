Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69850797C80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbjIGTFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjIGTFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:05:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13EE92
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 12:05:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500760b296aso1557210e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694113533; x=1694718333; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mIkOm/YABdxToyLIAayEfHr6UBc6LliTHdvA7T5lBYg=;
        b=oTJhuFvWmcN+Mv/oyDj2lgmhi07zsKDGvGKnL3728Ivkr/HThYMB+SCN+PwGCSsZLM
         okn4/ZGs142wnqcZQWLDHLe/io7coCoZh0ufFNBswPZLarfMDXYci7ugmLS6UFInbJ0H
         wEb4uq/dht946P8FFLlTS2xraZ6hVUgksNpGFlv4RhLR8Y4OHA7/2d8Cr068mAJGgbhE
         KPY0yL0qusnJh9yrpjRJZfT/JEHC38uAjQcOa0OuRzDidb/bos0HefluadeDtNlV0kfH
         eeJVV9buSDo6Y2IgOAKHYBOMSKqNvnZEnEeOugLj569lk7tVW0EXzqRgNggS3XBq/JTa
         HQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694113533; x=1694718333;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIkOm/YABdxToyLIAayEfHr6UBc6LliTHdvA7T5lBYg=;
        b=Xh1DdQfvMs5A9c86AULokgb+XjMaOk57rzJ90l7SimscSr3lijTelystqAkMzdNo1K
         52a7qlaHiPq6p/RNJhWsYft7YfQ08OVVKO4BXolTVaZljuEMz4yrLsty3DEoND/Bk7b6
         MHH17wMZiuG6YlrV0m0Sx7B8lqYkWglQUbmbi6JTtA919ledCf1dZjqP6L+r+S/0EjAD
         YKSE/aoqEu7/ynp9dwIq2Z1BA73k/A52JBIAvPhxgoFp+UgnMVDkInSJC4CmDLGo7hiK
         8tyNLekK2qDS+xatuGMbo7WeQtvEl7/UzMi0sg2otUu1bIntmRZR9Uc8G/HBc9FaYUER
         E7gA==
X-Gm-Message-State: AOJu0Yzt3gyGVcZtwdAcfhGsf8JMFtbX9vUJNSzxR1/Y/iYU9xeC2BGc
        c9wftxEooF1Iy6rPZmk+EVdBmSAnG8+LcVDgAg8=
X-Google-Smtp-Source: AGHT+IHJR0C651pfIvR3nwe75e72OkcySIEctote4SA2/I2QKNGRPg6busohgk73E+D7/iVOXNQ2pLt8JRzZKD7482g=
X-Received: by 2002:a05:6512:31c5:b0:500:96dd:f95a with SMTP id
 j5-20020a05651231c500b0050096ddf95amr118084lfe.24.1694113532822; Thu, 07 Sep
 2023 12:05:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:1a92:0:b0:237:a4ba:700a with HTTP; Thu, 7 Sep 2023
 12:05:32 -0700 (PDT)
Reply-To: ansongood7@gmail.com
From:   Anson Brudenell <komadon228@gmail.com>
Date:   Thu, 7 Sep 2023 12:05:32 -0700
Message-ID: <CAH6UFKb_ZaJJ4k1XTe9f1ondZ8FV+gBd5AFKe-5a4gbLbXNBQQ@mail.gmail.com>
Subject: =?UTF-8?Q?Buenos_d=C3=ADas=2C?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Buen d=C3=ADa,
Querido, por favor, =C2=BFpuedo hablar contigo?
Saludos,
Anson Brudenell.

.........

Good Morning,
My Dear Please can i talk to you?
Regards,
Anson Brudenell.
