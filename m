Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AC37D5875
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343935AbjJXQeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343881AbjJXQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:33:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F8AAF;
        Tue, 24 Oct 2023 09:33:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8476C433C7;
        Tue, 24 Oct 2023 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698165237;
        bh=+h560Vs2Q6PeyeqzhXCCQnpg0QmTLtd359Q4ZP0eXrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfUHETj0KKqljyg5YhJg2L51VBkaZuYXdqHzVPcRvVb5OfZ4ti/8JjXy///m7dpVI
         jfSPOiMvtnQyswOkY8ujr0PCjRAmfasjIbODbB8a6R2YOG1HJDDV1wb8syNNUgNC/I
         dCGGW7VpbO2ttulQWzxUled853tQxvimDXuSr/S6+Kz/WEfhHKcv+veFbNkizgYgyd
         GKZRL6uPBnPpS926x8s4f1QA4IIVJjhoWdgzo/Koe4k50whjo8gQY7mN+jwZpvX8Dc
         zVUlpFEoo08F7+GhsfSyhP/Tjg4GVlxQ7JxsDqdfcjN9racs3Fy9DIDWYx3z7wzW/X
         n5gmlxVCZWFGA==
Date:   Tue, 24 Oct 2023 17:33:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>,
        Adam Ward <Adam.Ward.Opensource@diasemi.com>
Subject: Re: [PATCH] dt-bindings: regulator: dlg,da9210: Convert to
 json-schema
Message-ID: <20231024-headband-trapped-7c03709854fa@spud>
References: <bfd1cf9d620a8229f5a5e62e6fe9e59c153d0830.1698051619.git.geert+renesas@glider.be>
 <20231023-sulfate-babble-695b239f52b5@spud>
 <CAMuHMdW7UQ=c9V6rjpZdcaNPSXLOu5aEiLhreirPP6NXN0Ke2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sPNKM9quhJNy5+0Z"
Content-Disposition: inline
In-Reply-To: <CAMuHMdW7UQ=c9V6rjpZdcaNPSXLOu5aEiLhreirPP6NXN0Ke2Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sPNKM9quhJNy5+0Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 07:58:51PM +0200, Geert Uytterhoeven wrote:
> CC David, Adam
>=20
> On Mon, Oct 23, 2023 at 6:18=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Mon, Oct 23, 2023 at 11:04:45AM +0200, Geert Uytterhoeven wrote:

> > > +maintainers:
> > > +  - Support Opensource <support.opensource@diasemi.com>
> >
> > This should really be a person... Does your work with Renesas cover you
> > for dialog stuff too?
>=20
> I'm not really into the PMICs department, only into making dtbs_check
> for "my" DTS files clean ;-)
> I hope one of the Dialog/Renesas PMIC people can point me to a better
> address.  Steve Twiss sent a goodbye message to some kernel people
> and lkml three years ago, but it is not on lore, as it contained HTML.
>=20
> Ah, according to git log, David and Adam touched some of the files
> lately, so perhaps they can help?

It'd be great if one of them could volunteer, aye. I do feel like I
recall seeing one of the folks involved with the dialog stuff in
mainline stepping down shortly after the merger though  :|


--sPNKM9quhJNy5+0Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTfx8AAKCRB4tDGHoIJi
0pSRAQDts64t0GCBblqr2GdHTL52vzFSCyvBwHVcmI0YwTeEfgD/TbW7rq9ZKVyQ
ux74TMBZBpeAfnvB9ZVoGPENqYF+CQc=
=UiJ8
-----END PGP SIGNATURE-----

--sPNKM9quhJNy5+0Z--
