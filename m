Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DEC78A9A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjH1KKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjH1KKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:10:17 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92E9C6;
        Mon, 28 Aug 2023 03:10:11 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 9297E20718;
        Mon, 28 Aug 2023 12:10:05 +0200 (CEST)
Date:   Mon, 28 Aug 2023 12:10:01 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [EXT] Re: [PATCH v4 1/1] wifi: mwifiex: added code to support
 host mlme.
Message-ID: <ZOxyeTdEXgxVZzAF@francesco-nb.int.toradex.com>
References: <PA4PR04MB96386B2937FE0F7BD0BFAEB3D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZOh8deIyeJMZAs7u@francesco-nb.int.toradex.com>
 <PA4PR04MB9638EAED5E4361F0429A796CD1E0A@PA4PR04MB9638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638EAED5E4361F0429A796CD1E0A@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Mon, Aug 28, 2023 at 09:30:08AM +0000, David Lin wrote:
> > On Tue, Aug 15, 2023 at 07:09:25AM +0000, David Lin wrote:
> > > 1. For station mode first.
> > > 2. This feature is a must for WPA3.
> > > 3. Firmware key api version 2 is needed for this feature.
> > > 4. The code is only enabled and tested with IW416.
> > > 5. This feature is disabled for other chips.
> > >
> > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > 
> > I think you are missing a few of the comments you received so far.
> > 
> >  - verify the recipient list, the list here was likely generated with an
> >    old kernel tree using an outdated MAINTAINERS file
> 
> I followed your suggestion and issued the command on latest wireless test repository.

Weird, you should have Brian Norris as recipient.

> >  - you need to provide a changelog in your patch, otherwise is not
> >    possible for other to review
> 
> Yes, one the cover page.

Whoops. I missed this since I am not cc: on this series and just found
it by chance. I would have just expected to have the changelog together
with the patch and not on the cover, given that it's a single patch.

Sorry for the misunderstanding, I would appreciate if you could keep me in
CC from now on, thanks.

Francesco

