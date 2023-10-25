Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABEC7D7833
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjJYWqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjJYWqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:46:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D547115
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 15:46:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83B4C433C7;
        Wed, 25 Oct 2023 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698273965;
        bh=EwGeoWVSmqUbhWycDaxzQ6Ek3vvzienMez1ubkrLYcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bpq8K2tloK8+334UjsyCgIy6woczN95xNwsl+ajM1RMS5654nzMqcRq3FjnTyKVAB
         w9qH2cWePYx5TGvFzdIt53OiYYcvTlwzwfYhN5tNOncNGu5h0Sv/VgW1JaSxMFtDx9
         5LUv2/4hB0S3GvGXAjTnXJAjiH6xNHiRgVYCNpaq53/4fvU/vCdfKhN25/UQXGGnDx
         ANJpvSRBHMEKexlS71iktJ4/oqf0c5rAXgyiesgra2MFJ5R+N560FFS0eEcnyzq3uw
         Zm0S/cDRlsCudH/vVxYr3WIwpjWGP4nAbwL6ego78E1DPvMVjGT7dG0iS7+u5AiiJP
         fLYZwkI6a29Nw==
Date:   Wed, 25 Oct 2023 15:46:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, richardcochran@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com
Subject: Re: [PATCH net-next v8 0/7] Add MACsec support for TJA11XX C45 PHYs
Message-ID: <20231025154603.61751dfb@kernel.org>
In-Reply-To: <20231025154044.7877e5c0@kernel.org>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
        <5d7021cd-71b1-4786-9beb-1a4fe084945c@oss.nxp.com>
        <20231025151834.7e114208@kernel.org>
        <20231025154044.7877e5c0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 15:40:44 -0700 Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 15:18:34 -0700 Jakub Kicinski wrote:
> > On Wed, 25 Oct 2023 19:21:24 +0300 Radu Pirea (OSS) wrote: =20
> > > The state of this patch series was set to "Changes Requested", but no=
=20
> > > change was requested in V8 and I addressed the changes requested in V=
7.=20
> > > Am I missing something or is it a mistake?   =20
> >=20
> > Another series got silently discarded because of a conflict.
> > This one IDK. Everything looks fine. So let me bring it back, sorry. =20
>=20
> Ugh, I found out why. It has already been applied :|

Sorry, ignore me =F0=9F=A4=A6=EF=B8=8F

I had it applied locally because I was checking if it applies cleanly.

