Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BA57F4C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjKVQRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjKVQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:16:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1497D41
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:16:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2F9C433C8;
        Wed, 22 Nov 2023 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700669813;
        bh=gnjtMK4pS8juI0a9kdN4S8I0WN77dg3aOR53D/91PXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXlrH0UO3dELezbaZOre2DyRuj73aehtvV66h0GzMuxPdyCr4QrlP19Co3jWchB1n
         g3Zqir7OXoapnd8pFPjFdwVLpR8tKUGNpjcyPZ9B8+wmrdFc4946kzyIJ6HIk3b6W3
         XtPuD2TC54Aw31pYBdLYPnL2DZzj01R4FlcafROoJ9M7bK7JUXXxpfQUWlwrP/4moC
         hcytvBKK6xfoakbMmCAGG27jocAQp9DXh7Qgtrb0eOJspbz+uQFOoKCR/C/hmBoHeY
         rcS3OQoeD1vjCrMip05pjXFZxrA5kE5wnpcPQy/07w5lZ7z2XImgdFEv0NimH4o74G
         jynTOPEGlGl1A==
Date:   Wed, 22 Nov 2023 16:16:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Jerry Shih <jerry.shih@sifive.com>
Subject: Re: [PATCH v4 00/20] riscv: report more ISA extensions through
 hwprobe
Message-ID: <20231122-detection-antler-124b9460e893@spud>
References: <20231114141256.126749-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U/2uIv7Yhb2wSwUv"
Content-Disposition: inline
In-Reply-To: <20231114141256.126749-1-cleger@rivosinc.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U/2uIv7Yhb2wSwUv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 09:12:36AM -0500, Cl=E9ment L=E9ger wrote:
> Changes in V4:
>  - Add a text specifying that Zkr string dt binding means that the CSR
>    provided by Zkr are accessible only by the privilege level to which
> the device-tree has been provided.

This text don't match what the change was. Here you say "only", but the
binding has the IMO correct wording, with "only" removed.


--U/2uIv7Yhb2wSwUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV4pcAAKCRB4tDGHoIJi
0rUqAP0dwQyCCmdgf5TjCz0Femc8nr1+zCexAneYj8slpm6vggEAuiD6EdxWLRpq
ndEmecDSWnY8Blrjc3NQy8JdQcNxPQA=
=jqFD
-----END PGP SIGNATURE-----

--U/2uIv7Yhb2wSwUv--
