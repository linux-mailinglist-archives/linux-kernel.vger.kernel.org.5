Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6AF75765D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGRIOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGRIOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:14:53 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75621137;
        Tue, 18 Jul 2023 01:14:50 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id C846D209AD;
        Tue, 18 Jul 2023 10:14:44 +0200 (CEST)
Date:   Tue, 18 Jul 2023 10:14:41 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>, Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Message-ID: <ZLZJ8djqkPIfT/FE@francesco-nb.int.toradex.com>
References: <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <20230505120618.2f4cf22c@booty>
 <ZFThyn/D/dDK9nk3@francesco-nb.int.toradex.com>
 <PA4PR04MB96405EE2468555EA900B340189739@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <ZFjaNzY32x8o2XG7@francesco-nb.int.toradex.com>
 <20230508151756.785ec07e@booty>
 <20230529121825.71e9b6d6@booty>
 <PA4PR04MB96405138465D215C34285F02894B9@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <ZKaWL3+ClI7iNr/4@francesco-nb.int.toradex.com>
 <20230717184537.6d6ed607@booty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717184537.6d6ed607@booty>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:45:37PM +0200, Luca Ceresoli wrote:
> On Thu, 6 Jul 2023 12:23:43 +0200
> Francesco Dolcini <francesco@dolcini.it> wrote:
> > On Tue, May 30, 2023 at 11:22:51AM +0000, Jun Li wrote:
> > > Yes, your understanding is correct, talked with Xu(in CC), he will take this
> > > soon.  
> > 
> > A series was posted
> > https://lore.kernel.org/all/20230627110353.1879477-1-xu.yang_2@nxp.com/,
> > I had no time to try or look at it yet.
> 
> Thanks for keeping me up to date on this topic, which is still totally
> relevant to me.
> 
> I looked at the series, but it does not seem to be addressing the
> problem with USB host not detecting new devices when VBUS is not
> directly connected, e.g. in the Colibri imx6ull SoM.

I recall having tried something similar, it could handle also the
colibri imx6ull use case. Were you able to try it? These days I am busy
with other tasks and I was not able to find the time (yet).

Francesco

