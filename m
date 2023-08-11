Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042177787A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjHKGrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHKGrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:47:17 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7786F2717
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:47:17 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d6265142e21so1540576276.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691736436; x=1692341236;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eeL5H+XAyEZXJG18X+f1zwPNB6nwhOm58j7w8zFayBI=;
        b=Z2kBa6YvvPywMsGjX+mpTLjWbvj0Cb5ywsBJo1b+uFoa/E0X3AC6ciw7hFN0OzjsgU
         OHZpTwsLJ13xVG7R/8pRv5YVZQJ2K1P3wXWZxUVZVD2p5+0WphyQtZ1+hayyXS+nC/Ux
         +0VgUC7NNNEXS7zi9l1Fvj1+0oeXiQ7RRM6OTNhpx0eBUxZEdhow3NbqrWrn8knKpTcN
         tnv1zah9RKPmCeBcE+rer2sq8qV9i6xvsfr3CmLTXysm63G+s47iBot+ypcMIMBG8WIm
         rkHGLv3BnhRIbRTM5U96bL8Hc22qV06W4coa6HN93MQR1EgQ318ybrY4vFRuDQmss0bu
         sedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691736436; x=1692341236;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeL5H+XAyEZXJG18X+f1zwPNB6nwhOm58j7w8zFayBI=;
        b=Kg6cr3uBnS45WU9HgIZZ0KhD/usuwaA4kHGj3ilSC7jxkBpvux40qT5C9kcziS0CMq
         Hc/U2DAeEGcIgyKHp6bTkSqeyXqZ2NCgGGN0zKYiOiED4Jsk/oyDS8HaQWW0+NfjK6vG
         Lud8cCA2B+DCeD7MPI1doeyFZfDNa+FD6XL7I4W9FYpmYeA8gDUSVBxtGwfrphMXmQMv
         XocuWtNYvso1eKjbLNLCt12QXuVDnBv7zRlLJ15A6pbrNIF6AzTCdF/tZttG6bdI6PiA
         kdjCbQG1bP5pwrgBHDK4xNwQpa5cQaZA/Qh+8Gx+4cVbMe5sr6/be/mDn6APKkd2S+X7
         /rHQ==
X-Gm-Message-State: AOJu0Yx6XeLepZ5T7oE4CeG5iABtXY5UtUsCYOlD+EOYAcEIjJhEc7q8
        B3bg/r2QgUr1TzxW9GQ7zlevU3/6LYHIK6vkoHg=
X-Google-Smtp-Source: AGHT+IFwpGEOwDGVosgbqNGT9zYsy9ktxmrSvH59D2RlNQXsSY6KX4tm2RTBm1NJAvzkgXU6bUtaCB4DWHk9QIQTUEA=
X-Received: by 2002:a25:d409:0:b0:d07:e343:1cf0 with SMTP id
 m9-20020a25d409000000b00d07e3431cf0mr905652ybf.8.1691736436369; Thu, 10 Aug
 2023 23:47:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:298e:b0:378:223f:71c with HTTP; Thu, 10 Aug 2023
 23:47:16 -0700 (PDT)
Reply-To: bertwus9@gmail.com
From:   =?UTF-8?B?TXIuIEZhemzEsSBLaGlzcm93?= <feouziyaplisono@gmail.com>
Date:   Fri, 11 Aug 2023 06:47:16 +0000
Message-ID: <CANiBEGWH=AMpgCey+EpOjADO4QTKbwbb=ZxGEwNv+D_FxaSO=g@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b32 listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [feouziyaplisono[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [bertwus9[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Greetings,

I am  Mr. Fazl=C4=B1 Khisrow and I work at a prime bank in Turkey I have
this proposal to introduce YOU to the bank as the next KIN, so if
willing to partner with me, please contact me and I'll detail the way
forward to achieving this success.

Thanks and blessings from God
F. Fazl=C4=B1
