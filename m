Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961FA7B8365
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbjJDPRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjJDPRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:17:49 -0400
Received: from smtp.inaport4.co.id (mta-2.inaport4.co.id [103.219.76.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC4BD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:17:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.inaport4.co.id (Postfix) with ESMTP id B24B1873D0DB;
        Wed,  4 Oct 2023 23:12:24 +0800 (WITA)
Received: from smtp.inaport4.co.id ([127.0.0.1])
        by localhost (mta-2.inaport4.co.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FXkN6dU-d5Sd; Wed,  4 Oct 2023 23:12:24 +0800 (WITA)
Received: from localhost (localhost [127.0.0.1])
        by smtp.inaport4.co.id (Postfix) with ESMTP id 26EB68734C53;
        Wed,  4 Oct 2023 23:12:24 +0800 (WITA)
DKIM-Filter: OpenDKIM Filter v2.10.3 smtp.inaport4.co.id 26EB68734C53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inaport4.co.id;
        s=67133E3A-D729-11EC-9A3E-209BEC03DFB2; t=1696432344;
        bh=+OpVF14sCn4z3UgNS8jJHJB2yZ6ydPdoPxuVM0dOK/g=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=tqgcRq9ltIpfdVheLUHECFM/9udfH6TmIrb7U3ZgWlNF0mVI8TBAa3aerJF7hfK4f
         N7swmbTqdgUUUjHRvCu4YRbuXNUWio+JhQzJJgEtWYp5cKBtmhRl00kpX8bpEzsM4k
         7lx26OHcCq+rwFoLxhwPvZIRC+OAnYKvBrPCJPPNXcxhaTjLgs6jDYpgO2xjrZ/oJh
         fESeJYUc+4d1y0Zwyl0qNmTnkjXxBFlTPh681N2b/eLT/O3yzy6TAEwUNTdaEk4Ipo
         AqNnSefivMVIwgrMjqIewLz0FaSlyRYRMyMhQa+BmKLe5Utmng1PLydPAgF3a6lfrd
         mAeki+O2LiFUg==
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-2.inaport4.co.id
X-Virus-Scanned: amavisd-new at 
Received: from smtp.inaport4.co.id ([127.0.0.1])
        by localhost (mta-2.inaport4.co.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yHpyPV61Pe4T; Wed,  4 Oct 2023 23:12:23 +0800 (WITA)
Received: from [100.122.60.88] (unknown [117.98.22.7])
        by smtp.inaport4.co.id (Postfix) with ESMTPSA id 167FB873D0DB;
        Wed,  4 Oct 2023 23:11:40 +0800 (WITA)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?QVRFTsOHw4NPIA==?=
To:     Recipients <celsiusantoni@inaport4.co.id>
From:   Administrador de Sistemas <celsiusantoni@inaport4.co.id>
Date:   Wed, 04 Oct 2023 20:41:14 +0530
Reply-To: sistemassadmins@mail2engineer.com
Message-Id: <20231004151141.167FB873D0DB@smtp.inaport4.co.id>
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3754]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  3.8 URI_PHISH Phishing using web form
X-Spam-Level: *****
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


