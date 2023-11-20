Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4CC7F16E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjKTPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbjKTPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:13:01 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6FBE;
        Mon, 20 Nov 2023 07:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=tdw78nVfIm7n5esUENVhDomIV1AhhrekYq+Vayl1qzc=; b=HEq2w6FPT6t4B3bHlc8R47NQWb
        YVOBWgUFREVmq4UeQ5Y9tW59Iaf4zovfq8K/cqa8CYoapuNNN/nGhEab8VPJzwNIhbucmnWI9KzkE
        zi6qNulEwf52gLIPT2NnfFOAZd7BLphfb8R3loxTxjqWI7EzR5wu98s1mTNVuwYDyJq0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49764 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r55x4-00085z-2T; Mon, 20 Nov 2023 10:12:43 -0500
Date:   Mon, 20 Nov 2023 10:12:40 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Message-Id: <20231120101240.f3b6dd4e8c2cfaa8b0c30b7e@hugovil.com>
In-Reply-To: <20231120072517.7b22ghddzs2w2w36@pengutronix.de>
References: <a46b493c6b5cfa09417e3e138e304fd01b61e748.1700410346.git.christophe.jaillet@wanadoo.fr>
        <20231120072517.7b22ghddzs2w2w36@pengutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] serial: imx: convert not to use
 dma_request_slave_channel()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 08:25:17 +0100
Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello Christophe,
>=20
> I didn't look at the patch, but only noticed the Subject while browsing
> my mail. In my (German) ear the sentence is broken. I'd do
>=20
> 	s/not to/to not/
>=20
> (Not converting the driver could also be an empty patch :-)

Hi,
I would suggest:

"serial: imx: replace deprecated dma_request_slave_channel()"

Hugo.
