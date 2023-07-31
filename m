Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD3B769B05
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjGaPpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGaPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137FE57;
        Mon, 31 Jul 2023 08:45:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56731611B5;
        Mon, 31 Jul 2023 15:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0BAC433C7;
        Mon, 31 Jul 2023 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690818313;
        bh=9udjBpt/Zp7OzlidJfQwT/FLES/wXTZtme7QhcIiy9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YjiyKxs18gJnxgliICQ6rv7z8JEMhuY7FvsEUvs2TvrfT09YvvcoOllj7QpOPiHwg
         H7TnPcKQjcXQcUMSKxAnRcWZpz76NuRz5XkayMvAO7xu/SwFDOMegbA1DKwUqg9QXK
         bZeBkiLQUHyJuGP9cEZ+tsv9/A6J+Tb2w7itKxXb0vtYrvGsjfF//49DcmDVIcq5Ek
         jwvANBnUJp6bsgILYRrEZuPSx30tNQbsxGmNFlmla7BmaAWCibaiPIM43EpJZqkf/8
         gOwAZQ6SE8XiKj0nJ9zQtYFjyTjczzBPFO0uK/3ilYn6KYoim09WnwGJf44xbtudwV
         aggbC9bEVokHQ==
Date:   Mon, 31 Jul 2023 16:45:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: power: qcom,rpmpd: Add compatible
 for sdx75
Message-ID: <20230731-recreate-gloomy-9ae9fdbbcd6b@spud>
References: <1690803007-8640-1-git-send-email-quic_rohiagar@quicinc.com>
 <1690803007-8640-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wYnIjZfWQhSn+39l"
Content-Disposition: inline
In-Reply-To: <1690803007-8640-2-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wYnIjZfWQhSn+39l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 05:00:06PM +0530, Rohit Agarwal wrote:
> Add a compatible string for power domains in sdx75.
>=20
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--wYnIjZfWQhSn+39l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMfXBQAKCRB4tDGHoIJi
0rD4AQCdqF/j7wlwIBHAzNjMlWl6Ib1oZheQ8nC3xvsHeqicWwD9GKD8rstey1/E
4EtgwQh0988AUnqbMuGY5fGOH2CQ+w0=
=SlUC
-----END PGP SIGNATURE-----

--wYnIjZfWQhSn+39l--
