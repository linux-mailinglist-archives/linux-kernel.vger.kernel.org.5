Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805AC7EB0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjKNNNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjKNNN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:13:29 -0500
Received: from smtp.inaport4.co.id (mta-2.inaport4.co.id [103.219.76.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3522D196
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:13:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp.inaport4.co.id (Postfix) with ESMTP id 1555281C491E;
        Tue, 14 Nov 2023 20:31:18 +0800 (WITA)
Received: from smtp.inaport4.co.id ([127.0.0.1])
        by localhost (mta-2.inaport4.co.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UFxNyhGfQIx3; Tue, 14 Nov 2023 20:31:17 +0800 (WITA)
Received: from localhost (localhost [127.0.0.1])
        by smtp.inaport4.co.id (Postfix) with ESMTP id 4AD2781C496C;
        Tue, 14 Nov 2023 20:31:15 +0800 (WITA)
DKIM-Filter: OpenDKIM Filter v2.10.3 smtp.inaport4.co.id 4AD2781C496C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inaport4.co.id;
        s=67133E3A-D729-11EC-9A3E-209BEC03DFB2; t=1699965076;
        bh=SOx2LvSBesZno7n0lI3FwGkekaKXl+GmbdmELrAl6u0=;
        h=Date:From:Message-ID:MIME-Version;
        b=ES723OZmF4aOdXkP8WMm9L4aX5huc7Fxyrcfo9HwQ5LvVUhwd0FUIEwp8wJNXtrVD
         q06W5uDH7YuzXuOS1OMEvnPEmrXVwEVXLHvSmpJl75owLqTgLMnbRNFe2RKIfGRXUj
         PFj6R63SifM8rSh6TLsmIJimcIazRhn6BzDrSf7nkm2+pRoWKV1fvekRqqqZkzou6n
         J4RbngvqG+QL90kN+5roc5VhgQgrHpsHqmGnnjENozYRbLGRSPZq3T8eNn4nAGEImH
         U6szAGpRgEOcRSb5OBjjx3r8tYDjNAvl7n4vNGP2gk0cCQV1xhvKwTsUsO/FqWrDcg
         3TUWlxh2Iny0w==
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-2.inaport4.co.id
X-Virus-Scanned: amavisd-new at 
Received: from smtp.inaport4.co.id ([127.0.0.1])
        by localhost (mta-2.inaport4.co.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uOmpmDK7hb4i; Tue, 14 Nov 2023 20:31:14 +0800 (WITA)
Received: from mailstore.inaport4.co.id (mailstore.inaport4.co.id [172.10.1.75])
        by smtp.inaport4.co.id (Postfix) with ESMTP id 9465181C491B;
        Tue, 14 Nov 2023 20:31:09 +0800 (WITA)
Date:   Tue, 14 Nov 2023 20:31:09 +0800 (WITA)
From:   Sistema =?utf-8?Q?Administra=C3=A7=C3=A3o?= 
        <suriadi@inaport4.co.id>
Reply-To: sistemassadmins@mail2engineer.com
Message-ID: <1143734499.409515.1699965069556.JavaMail.zimbra@inaport4.co.id>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.8_GA_3025 (zclient/8.8.8_GA_3025)
Thread-Index: ZkEPbW7Xwin69+krx3ciuSEcWT/rTg==
Thread-Topic: 
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,REPLYTO_WITHOUT_TO_CC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [103.219.76.7 listed in list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.0 MISSING_HEADERS Missing To: header
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATEN=C3=87=C3=83O;

Sua caixa de correio excedeu o limite de armazenamento, que =C3=A9 de 5 GB =
como definido pelo administrador, que est=C3=A1 atualmente em execu=C3=A7=
=C3=A3o no 10.9GB, voc=C3=AA pode n=C3=A3o ser capaz de enviar ou receber n=
ovas mensagens at=C3=A9 que voc=C3=AA re-validar a sua caixa de correio. Pa=
ra revalidar sua caixa de correio, envie os seguintes dados abaixo:

nome:
Nome de usu=C3=A1rio:
senha:
Confirme a Senha :
Endere=C3=A7o de e-mail:
Telefone:

Se voc=C3=AA n=C3=A3o conseguir revalidar sua caixa de correio, sua caixa p=
ostal vai ser desativado!

Lamentamos o inconveniente.
C=C3=B3digo de verifica=C3=A7=C3=A3o:@ADMINISTRA=C3=87=C3=83O.WEBMAIL..@202=
3..011024319.BR....@WEB.ADMIN.COM.BR
Correio T=C3=A9cnico Suporte =C2=A92023

obrigado
Correio Suporte do Sistema


