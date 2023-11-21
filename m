Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3951E7F29D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjKUKK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjKUKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:10:27 -0500
X-Greylist: delayed 91346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Nov 2023 02:10:24 PST
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2DEC1;
        Tue, 21 Nov 2023 02:10:24 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 0E5732065C;
        Tue, 21 Nov 2023 11:10:22 +0100 (CET)
Date:   Tue, 21 Nov 2023 11:10:20 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>, linux@bigler.io,
        Stefan Moring <stefan.moring@technolution.nl>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
Message-ID: <ZVyCDGWhOSYFQADe@francesco-nb.int.toradex.com>
References: <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
 <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
 <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
 <6322fd4c1967a518310140c35ab34f65@mail.infomaniak.com>
 <ZVsyVAapXTWnznFd@francesco-nb.int.toradex.com>
 <CAB3BuKDb6uucujD7ac-w4pa1GVNLSQUA4OGE7i074mQSU==WaA@mail.gmail.com>
 <ZVucAc2Nq0JwJ+N4@francesco-nb.int.toradex.com>
 <90abbd7a-e3e3-42c9-9be9-28e475f0fc9a@leemhuis.info>
 <ZVx1ic9/vxDDStoE@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVx1ic9/vxDDStoE@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:16:57AM +0100, Francesco Dolcini wrote:
> On Tue, Nov 21, 2023 at 10:06:51AM +0100, Thorsten Leemhuis wrote:
> > spi: Increase imx51 ecspi burst length based on transfer length
> > 15a6af94a2779d5dfb42ee4bfac858ea8e964a3f
> > 
> > spi: imx: Take in account bits per word instead of assuming 8-bits
> > 5f66db08cbd3ca471c66bacb0282902c79db9274
> 
> Do we know which one of those two commits introduces this regression?

Whoops again. The second one is a fix for the first one, so my question
does not make any sense, forget about this, sorry.

Francesco

