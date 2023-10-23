Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB54C7D2F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjJWKBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjJWKBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:01:45 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332F1DA;
        Mon, 23 Oct 2023 03:01:41 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id E04242067E;
        Mon, 23 Oct 2023 12:01:37 +0200 (CEST)
Date:   Mon, 23 Oct 2023 12:01:33 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH v6 1/6] wifi: mwifiex: added code to support
 host mlme.
Message-ID: <ZTZEfefJ8pvtnR7M@francesco-nb.int.toradex.com>
References: <PA4PR04MB9638DEFC074F41AAEE3AC471D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZTP1OXGExKCMk14D@livingston.pivistrello.it>
 <PA4PR04MB9638E6859D64EF4FC4762C03D1D8A@PA4PR04MB9638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638E6859D64EF4FC4762C03D1D8A@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 02:16:26AM +0000, David Lin wrote:
> > On Fri, Oct 20, 2023 at 03:48:11AM +0000, David Lin wrote:
> > I noticed that you ignored some (all?) of my feedback [1].
> >
> > Maybe my feedback got lost between the quotes, maybe you just forgot to
> > apply it. Please go back to the previous discussion and either implement all
> > requested changes or keep discussing them.
> >
> 
> I think I replied your request and follow it. Please check following link:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/PA4PR04MB9638DEFC074F41AAEE3AC471D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com/
> 
> Please press "Series:   | expand", you will find cover letter with
> related patches there. You can review any commit and reply the e-mail
> separately. Thanks.

I think we are not understanding each other, please have a look here
https://lore.kernel.org/all/ZRLsuJfxuvFk1K16@francesco-nb.int.toradex.com/
where you can find my comment on v4 of your series. I cannot find any
answer to that comments nor the changes I asked for implemented.

Francesco

