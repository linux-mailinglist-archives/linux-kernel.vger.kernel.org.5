Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89FA7A10F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjINW1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINW1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:27:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04772100;
        Thu, 14 Sep 2023 15:27:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAFDC433C7;
        Thu, 14 Sep 2023 22:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694730435;
        bh=EmM1Fj4IRisot8q6dW/zrrLwrixqcuq07f8dPOb0S88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwyeH9LbJt4M4yqGFMwweV0L4OkB9g123X3kin4hTCKwA0VpRG5wGVomI+Vi3v2r/
         s3giVzk7Ml/OtTMaUScaBn8/FRYof2Q0UKu39ILkUNO+QNMGGblt8KefyJe6p18mnJ
         TmhfmYsDehNONRRZqvQO2bQCSIWISe8ieVU9dZ5yOP++dn95dzgoaA0AVFJVZs+ffX
         FG16dHoVFr8a58P25wTeeYXCmcrEyybisFTO3OMxu/d4J35EW4OZki/BpY9XPe8LgS
         GwooYVkfPtJQOODb00zRQtbkPLTjue0xNjEKlOJ8KscxEs+yzDg7PdIgyJdklIIXyV
         dR4szhq0LLXKg==
Date:   Thu, 14 Sep 2023 23:27:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>
Subject: Re: [PATCH 13/17] pmdomain: starfive: Move Kconfig file to the
 pmdomain subsystem
Message-ID: <20230914-deviant-cohesive-8192f502e593@spud>
References: <20230914111904.586744-1-ulf.hansson@linaro.org>
 <20230914-delegator-dimple-51b9414caa28@wendy>
 <CAPDyKFrn=poSJA2ocAYUZUBdJpPFeNBZhzOubnkPXjnJWbcPeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7d8Sj+trL1MxhB4H"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrn=poSJA2ocAYUZUBdJpPFeNBZhzOubnkPXjnJWbcPeA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7d8Sj+trL1MxhB4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 12:24:55AM +0200, Ulf Hansson wrote:
> On Thu, 14 Sept 2023 at 14:00, Conor Dooley <conor.dooley@microchip.com> =
wrote:
>=20
> I guess I consider this as an ack, assuming the above gets changed?

Here's an explicit for w/ that change:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7d8Sj+trL1MxhB4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQOIvwAKCRB4tDGHoIJi
0hi1AP9dit2Xnpu5CvWLjJ+oeb3qLJXx8a0LwIBYo9vQWwWyzwD/aLYQvbxf10yw
AiNk4Yk5+qRyT+LgYGj3CP4Ii6+k3wQ=
=y+r5
-----END PGP SIGNATURE-----

--7d8Sj+trL1MxhB4H--
