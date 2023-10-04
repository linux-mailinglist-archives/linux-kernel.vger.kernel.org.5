Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDD7B7AA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbjJDIvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjJDIvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:51:20 -0400
X-Greylist: delayed 1717 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 01:51:15 PDT
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E8EA6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:51:15 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1e27:0:640:d1a0:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id E40ED60023;
        Wed,  4 Oct 2023 11:50:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id foS3o8UBRW20-tUDXFYtQ;
        Wed, 04 Oct 2023 11:50:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
        t=1696409442; bh=zM+u3qsfoQEbvh3xE4dw9ke9cQVd58SQUi8UgEKL540=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=j29k4leNHx8a7qGM0ubzaPiVQuAmAsbzdHgOG4nNcVgBJPJVdkvSd8zpO2bSYgivC
         aEtgw5L3pwqjc1rD6lij4Bf2M2CGpRkpX20fo0K3kEALq/DgKrZBbaTrQbGTWHJf6Q
         e7R5layHB+C3xI8unwP07dGwn9Mdr+c6m4oPGvUU=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <c25184612d669dbb06f3d56239f2a9222b6acb70.camel@maquefel.me>
Subject: Re: [RFC PATCH v2] mtd: nand: add support for ts72xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Date:   Wed, 04 Oct 2023 11:50:41 +0300
In-Reply-To: <20231004103911.2aa65354@xps-13>
References: <20231004082223.12762-1-nikita.shubin@maquefel.me>
         <20231004103835.55cccdc6@xps-13> <20231004103911.2aa65354@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miqu=C3=A8l.

On Wed, 2023-10-04 at 10:39 +0200, Miquel Raynal wrote:
>=20
> miquel.raynal@bootlin.com=C2=A0wrote on Wed, 4 Oct 2023 10:38:35 +0200:
>=20
> > Hi Nikita,
> >=20
> > nikita.shubin@maquefel.me=C2=A0wrote on Wed,=C2=A0 4 Oct 2023 11:22:23 =
+0300:
> >=20
>=20
> BTW, subject prefix should be "mtd: rawnand:".

All comments acknowledged they will be fixed in series.=20

>=20
> > > Technologic Systems has it's own nand controller implementation
> > > in CPLD.
> > >=20
> > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > > ---
>=20
> Thanks,
> Miqu=C3=A8l

