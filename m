Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B15C75FDE3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGXRgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjGXRgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8630D98;
        Mon, 24 Jul 2023 10:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B4CA61290;
        Mon, 24 Jul 2023 17:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD88C433C7;
        Mon, 24 Jul 2023 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690220199;
        bh=wfpRK3iqU2vDNIEW0PQwmrw2Jp5S1c6RnHqkDJom1Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z1rzgNwRtzvQW44fcg+df3m1ltuUiQQvjTUO2Fqx9mZLulXrshPjMPxCu7zcphCNL
         x27RWih7M3Nt0aNaaKbEr+v1ZZallVuboUXYIf0jgalUtjpSKOFqzVBTjHAn4WEq54
         PUL6qi/tXrU1G8e/Xij0rjcJ4bJGOHOERnuaQYIMeQ+yztnnRYr/CMxKrC7GobuMxw
         waq+Or+2u/4EfivG4PcbutSzyiP2Am41nVKn9UOyYCO0dNrFl/9vx2j7M5JoQNTqWs
         y/6as2wBdgK+bY5rIvG3mdgWY9ge2GgaJG5VysseSnUACkNJ0S4aCbmjd0pWC0YxIc
         vXtHbQmPMlFQA==
Date:   Mon, 24 Jul 2023 18:36:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/3] riscv: Add BeagleV Ahead board support
Message-ID: <20230724-unwatched-left-f38189206b0d@spud>
References: <20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="D9uVPocj5ZxF/vpH"
Content-Disposition: inline
In-Reply-To: <20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D9uVPocj5ZxF/vpH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 10:20:37AM -0700, Drew Fustini wrote:
> The BeagleV Ahead single board computer [1] features the T-Head TH1520
> SoC. Similar to the Lichee Pi 4A series from Jisheng [2], this adds a
> minimal device tree file to support booting to a basic shell [3].
>=20
> Changes since v1:

> - Add dual license to dts file as Conor noted this is typical

I figure the dual licensing of the dtsi & sipeed board will be done
separately?

What's here is=20
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--D9uVPocj5ZxF/vpH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL62ogAKCRB4tDGHoIJi
0nJOAQD+jtDm9BjBEfTrhb0bd1bzMuFVIVMn22jD5gqDQhxVhgD9HONE83smPhGU
5cINM7em1QnEtx+OWctkUf+pnj/FkAw=
=rYTt
-----END PGP SIGNATURE-----

--D9uVPocj5ZxF/vpH--
