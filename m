Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A7F763EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGZSjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGZSjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10696E7E;
        Wed, 26 Jul 2023 11:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94AA561C54;
        Wed, 26 Jul 2023 18:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05377C433C7;
        Wed, 26 Jul 2023 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690396747;
        bh=8+Om66fq5vH8tTHbxMnZl3lSxX9EY3u29MUPAIlkj84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcFaUgXV1kHXiX7vgQq1Vy2wMUSpdmjcQYRGg1zsYS1vPNqpSMDCFhhHX6dYgBITi
         gKlGm+3MfXne6+gZbeugaMbLIjH5+dAxJQ0zl211dlkISYCM3mHG+hBTnGb5DeWCad
         vfHSerbTRld4mxk7L7Nmwrbipy01CLWxyvCW+HI2XdDSJ80jhMdALIaUSgHNrkQ57k
         yZx9anXUd2RXVX8khe82v+Yf5U6ULW9N8USB/KcpRY5u1BJLyJK+jUJjpbgGKiUSac
         g2ZipnOZTMepRWHv+b0EGr1Uh+ZJzto55erMHFF85IvWvQmOpRBrs0/uHlQ6UFSjxA
         KtTmdLjo8IYHA==
Date:   Wed, 26 Jul 2023 19:39:01 +0100
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
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: add reviewer for T-Head RISC-V SoC
 support
Message-ID: <20230726-brutishly-skeptic-7aa83d27f359@spud>
References: <20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v2-3-a470ab8fe806@baylibre.com>
 <ZMBmalZwaRCiy2BG@xhacker>
 <CAFTh7p3m+4kLxPV+NXJWSRW-ZDZv930z=SbfuELmgcZFnQ4fig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k6PL8mYmCJJPogle"
Content-Disposition: inline
In-Reply-To: <CAFTh7p3m+4kLxPV+NXJWSRW-ZDZv930z=SbfuELmgcZFnQ4fig@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k6PL8mYmCJJPogle
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 06:38:16PM -0700, Drew Fustini wrote:
> On Tue, Jul 25, 2023 at 5:30=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org=
> wrote:
> >
> > On Mon, Jul 24, 2023 at 10:20:40AM -0700, Drew Fustini wrote:
> > > I will maintain support for the TH1520-based BeagleV Ahead board so
> > > adding myself as a reviewer for T-Head SoC patches.
> >
> > Hi Drew,
> >
> > Thanks for your interest in maintaining the SoC support part. However,
> > maintainership involves active reviewing and maintaining the whole SoC
> > support part and not just specific board part, although currently, the
> > SoC support in mainline is minimal. I'd like to see your patch
> > reviewing, testing and so on.
>=20
> Yes, that is understandable. I was just adding a Reviewer entry as I
> am supporting the BeagleV Ahead and I would like to test patches
> related to the th1520.  But it is not too big of a deal as I am also
> subscribed to all the relevant mailing lists that would receive
> patches.

You can always add a new MAINTAINERS entry that matches only the
th1520-beaglev stuff, if being added to the main entry is not
acceptable.

--k6PL8mYmCJJPogle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMFoRQAKCRB4tDGHoIJi
0q2XAQDcF6byw5/+G+if5307AhUC2ZglmdVuLxyzt3Ow6vPuIAEA473xXpj2wcsH
NZ7yhpYCDCv4MDPGyecFaUSXBdCDiAs=
=y1tX
-----END PGP SIGNATURE-----

--k6PL8mYmCJJPogle--
