Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88FD7B7A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbjJDIjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjJDIjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:39:16 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD57083
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:39:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D22A31C0008;
        Wed,  4 Oct 2023 08:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696408752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/XYEYq73ZO+zD7F2L6Y1MmfY4dJus72lVk4ppYFdpk=;
        b=e3o/+HfErmLGqISJrDYJMUi2DTIPOSikg66HhiNkzV1ZZdK+zNoZABggUHI5tRdYcyvfSs
        yC+GDsysnAvI3BA3u0VbuXB/YAW0IVyPJ9oxrsoSsBRqh98t/OALLdqwkSUuw3nslx+YZw
        FlSsqlkbt7RLz/nm/x/6fp7w+1EUmwnuMSRemthH7HG517v1GefGfJ+UkcHxqlkilG+O+6
        Zpk2HqTSIg9LxRu5NoyGvkAwyvrnp7QLcmdbuu82zj1JogYhN/JGLWpHS+sVa0LoJCk7Ay
        mVswbRskpuN+3Cg/i8x9W1APF7i/ACxvciE6/yo0haHmy/Y2/QuGnJHGvgRWtA==
Date:   Wed, 4 Oct 2023 10:39:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH v2] mtd: nand: add support for ts72xx
Message-ID: <20231004103911.2aa65354@xps-13>
In-Reply-To: <20231004103835.55cccdc6@xps-13>
References: <20231004082223.12762-1-nikita.shubin@maquefel.me>
        <20231004103835.55cccdc6@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


miquel.raynal@bootlin.com wrote on Wed, 4 Oct 2023 10:38:35 +0200:

> Hi Nikita,
>=20
> nikita.shubin@maquefel.me wrote on Wed,  4 Oct 2023 11:22:23 +0300:
>=20

BTW, subject prefix should be "mtd: rawnand:".

> > Technologic Systems has it's own nand controller implementation in CPLD.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---

Thanks,
Miqu=C3=A8l
