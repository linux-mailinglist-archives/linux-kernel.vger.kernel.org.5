Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3C7DA0A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346270AbjJ0Sim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjJ0Sil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:38:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535F7C2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:38:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A09C433C7;
        Fri, 27 Oct 2023 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698431917;
        bh=ST4J4uVD7J/Mq/vL7XaZM3mtZ3PwaVzL06JUPaESq9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbLXCIvymjtmabOlRja1JfUu227rsbH09ABUPCat0bpYPi6WIZl1Pb2j7k+Iyp3nn
         hngm5E3WTkLFgjQQ78EWCRFxYTR6bXnlHKxl9v+b41z0WZgtgVrTpKoWnZfFI1d43Z
         I9WFavBLdwNddrmA8F6aYO5XdxwFDRnOLfukH8AVEi2tMdU3uNLUsiVFkrMX/gqorN
         ordH55IwUfqQd8L/VQ+cAPEn+YaPl4oedOVpFLP4mj+q/OjiVn8UJooq05myswfJJj
         TIYiSZA7LEZiacNU4LMvo5yEyuwtFRU5MfdIF49CD+uFr3oAvYODKBtpTVhPe1pD8U
         8P2RrSgBKVcDA==
Date:   Fri, 27 Oct 2023 19:38:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 1/4] dt-bindings: cache: sifive,ccache0: Add StarFive
 JH7100 compatible
Message-ID: <20231027-freezing-pointed-53c73b0ae227@spud>
References: <CAJM55Z-vw1sbks0KcHOXMzP-6c9NMg+GOndi2pQ7iyWh0=oQiQ@mail.gmail.com>
 <20231026-paycheck-equation-b0f1a1191bf2@spud>
 <20231027182236.GA2853373-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SeokC8kRK7bMnsPN"
Content-Disposition: inline
In-Reply-To: <20231027182236.GA2853373-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SeokC8kRK7bMnsPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 01:22:36PM -0500, Rob Herring wrote:
> On Thu, Oct 26, 2023 at 02:10:37PM +0100, Conor Dooley wrote:
> > On Wed, Oct 25, 2023 at 11:56:37AM -0700, Emil Renner Berthing wrote:
> > > This cache controller is also used on the StarFive JH7100 SoC.
> > > Unfortunately it needs a quirk to work properly, so add dedicated
> > > compatible string to be able to match it.
> > >=20
> > > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.c=
om>
> >=20
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Did you want me to pick this up? Or you or Palmer will?

Me or Palmer I guess, I was going to take the lot together through soc.

Cheers,
Conor.

--SeokC8kRK7bMnsPN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTwDqQAKCRB4tDGHoIJi
0ublAP9H4KL8LXkV1jQ9dF6slNKqtn+yMaV3hmHpa4k2f/lnowEA7Wl2/62I5sVs
OBGRLUt/nQSPEMzEklP7Tup5Er1tEwE=
=Kmup
-----END PGP SIGNATURE-----

--SeokC8kRK7bMnsPN--
