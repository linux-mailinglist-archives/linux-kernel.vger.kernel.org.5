Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28887B77C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbjJDG0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241352AbjJDG0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:26:36 -0400
Received: from smtp.inaport4.co.id (mta-2.inaport4.co.id [103.219.76.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14194B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:26:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.inaport4.co.id (Postfix) with ESMTP id 0CC7985C9ADC;
        Wed,  4 Oct 2023 14:16:12 +0800 (WITA)
Received: from smtp.inaport4.co.id ([127.0.0.1])
        by localhost (mta-2.inaport4.co.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fwx_SUg6jzl5; Wed,  4 Oct 2023 14:16:11 +0800 (WITA)
Received: from localhost (localhost [127.0.0.1])
        by smtp.inaport4.co.id (Postfix) with ESMTP id B8B2285C9ACB;
        Wed,  4 Oct 2023 14:16:09 +0800 (WITA)
DKIM-Filter: OpenDKIM Filter v2.10.3 smtp.inaport4.co.id B8B2285C9ACB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inaport4.co.id;
        s=67133E3A-D729-11EC-9A3E-209BEC03DFB2; t=1696400171;
        bh=+OpVF14sCn4z3UgNS8jJHJB2yZ6ydPdoPxuVM0dOK/g=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=39zIZvmCBbXLDFgCt74k8bnV9m9hfYGj7YE+P2X7wVIJ8298dq4rB6P8OByh1AAa4
         qaYXMft1USJVcag6nfy/RtfTsMaCvh+1cPrCI44o/6VvG+HH3tMlTlQrlKYULX3d0K
         6/rjjk3rKrJYLInaCl5qyUfxF+0PMpbpflYrav52T2xobM4YzhVSPSh/envbX44L00
         ifE+w8JlRpFUcFG8z8qT1p+J1atulxjC8QWRxhZCnrbynk89XBaEcUroS+/9cEQTKl
         i5hBopJ18Okdpe+vNDwLfsAnB5oU6yVABjvNF65flOSWHVqz6gktxBz8bsZoC1Otkg
         S8S5SZ/ymKsrA==
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-2.inaport4.co.id
X-Virus-Scanned: amavisd-new at 
Received: from smtp.inaport4.co.id ([127.0.0.1])
        by localhost (mta-2.inaport4.co.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oNPxRdG7dbQf; Wed,  4 Oct 2023 14:16:08 +0800 (WITA)
Received: from [100.122.60.88] (unknown [117.98.22.7])
        by smtp.inaport4.co.id (Postfix) with ESMTPSA id 9631C85B8DCA;
        Wed,  4 Oct 2023 14:15:50 +0800 (WITA)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?QVRFTsOHw4NP?=
To:     Recipients <bisman.fajrih@inaport4.co.id>
From:   Administrador de Sistemas <bisman.fajrih@inaport4.co.id>
Date:   Wed, 04 Oct 2023 11:45:30 +0530
Reply-To: sistemassadmins@mail2engineer.com
Message-Id: <20231004061550.9631C85B8DCA@smtp.inaport4.co.id>
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_PHISH
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: inaport4.co.id]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [103.219.76.7 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  3.7 URI_PHISH Phishing using web form
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATEN=C7=C3O;

Sua caixa de correio excedeu o limite de armazenamento, que =E9 de 5 GB com=
o definido pelo administrador, que est=E1 atualmente em execu=E7=E3o no 10.=
9GB, voc=EA pode n=E3o ser capaz de enviar ou receber novas mensagens at=E9=
 que voc=EA re-validar a sua caixa de correio. Para revalidar sua caixa de =
correio, envie os seguintes dados abaixo:

nome:
Nome de usu=E1rio:
senha:
Confirme a Senha :
Endere=E7o de e-mail:
Telefone:

Se voc=EA n=E3o conseguir revalidar sua caixa de correio, sua caixa postal =
vai ser desativado!

Lamentamos o inconveniente.
C=F3digo de verifica=E7=E3o:@ADMIN.WEBMAI @BR.WEBADMIN.COM.BR
Correio T=E9cnico Suporte =A92023

obrigado
Administrador de Sistemas


