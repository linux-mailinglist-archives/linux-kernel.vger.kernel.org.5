Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6F67B49AE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 23:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjJAVRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 17:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjJAVRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 17:17:38 -0400
Received: from correo1.cdmx.gob.mx (mtax.cdmx.gob.mx [189.240.235.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F02D3;
        Sun,  1 Oct 2023 14:17:35 -0700 (PDT)
Received: from cdmx.gob.mx ([10.250.108.150])
        by correo1.cdmx.gob.mx  with ESMTP id 391LGp95016858-391LGp97016858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 1 Oct 2023 15:16:51 -0600
Received: from cdmx.gob.mx (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTPS id D3E6B242D16;
        Sun,  1 Oct 2023 15:10:25 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id B2ED6242D45;
        Sun,  1 Oct 2023 15:10:25 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx B2ED6242D45
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=cdmx.gob.mx; s=DKIM1; c=relaxed/relaxed;
 h=content-type:mime-version:subject:to:from:date:reply-to:message-id;
 bh=xoaq/LOC+4eKTZbu2LiokxnQv3PTDgn4X2fWdi3yHqc=;
 b=XDcbsYzIY8IsipVl0MuieR31MS0eppKJ9QUrFzs7hx0v99u7cBusPh1nOv27bxqg2xpyf/Dve+YG
        QMbH9H1xo6qMsui5bie4SRgFwDVndM4oCEuUg0iVc74lNWPPNB5z/vlzPh4JG2s/cXxyQBpj8+tG
        etmhWlu0PGe63kyojFtNBDudpEYKTlkAhKd5fDVPpCYqRXSUSfzretvdGKc6vJaBn6E+lcne15wc
        dmm3USgh5kPV6anrrT8feL2ZLgKXBD6N13yLUAqRfbL8x/dZNM5tUyGFLbq9qt3rBSQFomOJfDVB
        1zUwX/UjsjRYuhI7QdNYppI35NC5gXEKiMpRiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=2020J4N146MXCTY; t=1696191025;
        bh=gh/gHv0AhChJuqpyakBErmR9XX7JItsFvInX1t4m/Ao=;
        h=Content-Type:MIME-Version:Subject:To:From:Date:Reply-To:
         Message-Id;
        b=GYFX5tqgWFWjj0+pdiCx1k70RjjH7pOK/8AsBScpN7AUz0BPa4vUZ+JqyyubVOKfc
         yKXpohyjNUyUFd8IMdHzhy0oVEvTp6zkK2iqG7ikYQEv+86FgtUX/hS7TiiK/SttNU
         ExmjjfH1kVHBSR7pLdrFQQcmHq6LM1S7bLRYDbL8=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y04XKiYnXFkQ; Sun,  1 Oct 2023 15:10:25 -0500 (CDT)
Received: from [192.168.8.123] (unknown [179.61.245.35])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 00841242D16;
        Sun,  1 Oct 2023 15:10:17 -0500 (CDT)
Content-Type: multipart/alternative; boundary="===============0374931868=="
MIME-Version: 1.0
Subject: $4,800,000.00 dollars for you.
To:     Recipients <sgila@cdmx.gob.mx>
From:   "Mrs. Mavis Wanczyk" <sgila@cdmx.gob.mx>
Date:   Sun, 01 Oct 2023 14:10:43 -0700
Reply-To: maviswanczykfunds@gmail.com
Message-Id: <20231001201018.00841242D16@cdmx.gob.mx>
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        HK_NAME_MR_MRS,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,SPF_HELO_NONE,
        SPF_PASS,SUBJ_DOLLARS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8406]
        *  0.1 SUBJ_DOLLARS Subject starts with dollar amount
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 HK_NAME_MR_MRS No description available.
        *  2.3 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You will not see this in a MIME-aware mail reader.
--===============0374931868==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body

Hello, I have a donation worth $4,800,000.00 dollars for you, I won the Ame=
rica lottery worth $758 million Powerball jackpot and I donated a part of i=
t to charities. you can contact me for further information via (maviswanczy=
kfunds@gmail.com) for your claim.
--===============0374931868==
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body

Hello, I have a donation worth $4,800,000.00 dollars for you, I won the A=
merica lottery worth $758 million Powerball jackpot and I donated a part =
of it to charities. you can contact me for further information via (mavis=
wanczykfunds@gmail.com)) for your claim.

--===============0374931868==--
