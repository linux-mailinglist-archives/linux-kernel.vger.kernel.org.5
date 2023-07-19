Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EE5759D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGSS1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGSS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:26:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C6C1FDC;
        Wed, 19 Jul 2023 11:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71D02617CF;
        Wed, 19 Jul 2023 18:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94506C433C8;
        Wed, 19 Jul 2023 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689791207;
        bh=j2n5w0iDHqceFh/zcYF1K66xYVrTMsBMIJYklZgsxWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DrbOiIEN2ubDOvjGPIpJDrhlkvoyjyIMPKIXE/FROKtOHrcxuXe6zFUYmB7vnnzFG
         eoY1Y/M/3H+4kTe6s5DABXltXwIE6uT0JqJOcLUNDm5OyvC+e/59yYZAzFdTEC+aOJ
         MQWcUrjl073N+K+owljRf+zo+B15xZiL85m11/TkcRTVJK/FGH8B6K1dgcNOrowlLo
         OXeI8mLHRWWRtynNp2PDT1bc8fPel+0dccVSBFV3EA2qLL1jdQK2aPTzvRlxYyE6uM
         6xthwltUrAJF5WnCwoenDR7w9I8pPd0yfGqt9JitbCAUdVEqAdeAQFDC2qVUlJmu/f
         MSWXFqoCVZUzA==
Date:   Wed, 19 Jul 2023 11:26:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        linux@leemhuis.info, krzk@kernel.org
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of
 small time maintainers
Message-ID: <20230719112646.52977803@kernel.org>
In-Reply-To: <71224ff9-98d0-4148-afb8-d35b45519c79@sirena.org.uk>
References: <20230718155814.1674087-1-kuba@kernel.org>
        <71224ff9-98d0-4148-afb8-d35b45519c79@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 20:55:37 +0100 Mark Brown wrote:
> > +Maintainers must be human, however, it is not acceptable to add a mail=
ing
> > +list or a group email as a maintainer. Trust and understanding are the
> > +foundation of kernel maintenance and one cannot build trust with a mai=
ling
> > +list. =20
>=20
> If you're revising this I'd add a note about the L: tag in MAINTAINERS
> here, or possibly just adding a list in addition to humans.  It is
> sensible and often helpful for companies to want to get mail copied to a
> wider distribution list internally but they're not really what we mean
> by list since external people typically can't join them.

=F0=9F=91=8D=EF=B8=8F Added: "Having a mailing list *in addition* to humans=
 is perfectly
fine."
