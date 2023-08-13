Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD477A5D7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjHMJre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 05:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHMJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 05:47:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9525110CE;
        Sun, 13 Aug 2023 02:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D1962284;
        Sun, 13 Aug 2023 09:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCC8C433C8;
        Sun, 13 Aug 2023 09:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691920053;
        bh=YgbUmYl+Yx99mfAWxYEHS4jfvBC38g7adS+T8rc1CiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYxVr7EHEtk/NKZI0tSU0Hl5PHL54KqhGIHuP1iIEiNLDTFZG+7xPQRoIb/TuyExQ
         MqMBVLImyUEKf/Ne8KIftSBwfmEh3pld90tcvsLL+/0rmqx78wqxIppLAkY+/f4Xno
         JXSa+v2eMTvucpyM4FtBm5KpGEREpfzDzHn745ixI3OeSheY8s1ov5pa2DZjcnJdLK
         zNOtxWJziEvYYFEFVf1tXV6wkFU067MfPjs4VQVBK95DuCHquGGKLw+WG3+PehBVX7
         w7aN8RimL2Bpq9eHw1hsLdiJ1mbzt843nOhz7huQaeTFurxpGzeXKT2GZc1RUAr3rr
         cvjl9SQAF4xDg==
Date:   Sun, 13 Aug 2023 10:47:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: arm: qcom: Document MSM8x26-based Lumia
 phones
Message-ID: <20230813-refried-wager-9562c4e0d0e6@spud>
References: <20230811213728.23726-1-rayyan@ansari.sh>
 <20230811213728.23726-2-rayyan@ansari.sh>
 <b0494557-5676-4157-bc3b-bacd189c38d9@linaro.org>
 <25407bfd-0da9-7179-7c35-1fa1cc415ad2@ansari.sh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="33Pkvuimr/WUhhDN"
Content-Disposition: inline
In-Reply-To: <25407bfd-0da9-7179-7c35-1fa1cc415ad2@ansari.sh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--33Pkvuimr/WUhhDN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 12, 2023 at 12:50:28PM +0100, Rayyan Ansari wrote:
> On 11/08/2023 23:58, Konrad Dybcio wrote:
> > On 11.08.2023 23:35, Rayyan Ansari wrote:
> > > Document MSM8226 and MSM8926 Lumias.
> > >=20
> > > Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> > > ---
> > >   Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Docume=
ntation/devicetree/bindings/arm/qcom.yaml
> > > index 450f616774e0..ea4b1c530461 100644
> > > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > > @@ -181,9 +181,18 @@ properties:
> > >         - items:
> > >             - enum:
> > > +              - microsoft,dempsey
> > > +              - microsoft,makepeace
> > > +              - microsoft,moneypenny
> > >                 - samsung,s3ve3g
> > >             - const: qcom,msm8226
> > > +      - items:
> > > +          - enum:
> > > +              - microsoft,superman-lte
> > The '9' in msm8926 means "LTE".. is there a non-LTE superman?
> Yes, Lumia 730, based on MSM8226.
> I didn't just make up this codename, the 735 is called superman_lte in
> internal files.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Thanks,
Conor.

--33Pkvuimr/WUhhDN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNimsAAKCRB4tDGHoIJi
0tz1AP9I0XAlxgDho5Z7jqDMc0B2Lb3KC9kIFWyytTIvUJ/0WwEAk2DE0mMXECMh
QQAT1DjuavrhR0OhpS1jsf2rqPKlqwg=
=S7gL
-----END PGP SIGNATURE-----

--33Pkvuimr/WUhhDN--
