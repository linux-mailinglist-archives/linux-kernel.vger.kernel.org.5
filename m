Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0F17FA902
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjK0Sfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0Sfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:35:51 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE661DC;
        Mon, 27 Nov 2023 10:35:56 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C97DBFF803;
        Mon, 27 Nov 2023 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701110155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pc1dK8aGf5N+ZGXLXuYK7yI/sgVAfECJyWAgPuDAf8=;
        b=FVV6gLctHTH5WH+azA/EbdLUT+joHm/MLfPtZF+xvorcvbC1VSUnSLTgggcgTEilKRBR2d
        ztEbOXNXAtGbGwnwpJMGKNfSKpI5Znr62hBkD8A7s/CKbcdAw9x9HkQv/8sedfKFn4/ERM
        tjapWIdiiYweHJs8HRGXG+R78EkuEzVrPo0bEIXlsTVD1p02zma+bd0L/Tys/fU4gbaVMM
        rHJV+6I35gzldItprm/Z90xlnYZAFCsQq9oarolikTB8IeqUX80PrI5D4K4YUhQZdi/Mux
        eqwVGE3FfEZHEHboMirN9BSrpx+E0uMzj9GGI91hLg6OfptF2iPbFDcZm8bqAA==
Date:   Mon, 27 Nov 2023 19:35:52 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231127193552.1bcfe0ab@kmaincent-XPS-13-7390>
In-Reply-To: <20231124192407.7a8eea2c@kernel.org>
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
        <20231124192407.7a8eea2c@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 19:24:07 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 22 Nov 2023 14:52:43 +0100 Kory Maincent wrote:
> > Jakub could you create a stable branch for this patch and share the bra=
nch
> > information? This way other Maintainers can then pull the patch. =20
>=20
> Tagged at:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git
> firmware_loader-add-upload-error

Thank Jakub!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
