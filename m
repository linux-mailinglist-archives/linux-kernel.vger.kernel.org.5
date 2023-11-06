Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CEC7E1816
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjKFAFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFAFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:05:11 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958C7D8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 16:05:08 -0800 (PST)
Received: from [192.168.68.112] (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C790720075;
        Mon,  6 Nov 2023 08:05:05 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1699229106;
        bh=EWNKlHcvgb9LcHwcwUv91j9u/g4apLHIrE6bm+kVLT4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=QxNSspXy6OvxaY2pnJ5AXiRhVTgGzKUwY3toq0p7MdZtRTm23gQsAmqDWfVXPWB3i
         evFLqRuGMjELjpu/q4sm5RzU3uMXAlnExK9RuJMJZK66brHZCoItju4dR9jAOOfDNg
         /3XvdZEGhbXlDfLBMCk8/DlUprPzR1TiIddndbGLs1IUHgGm49l6h9lV+1cDSFFHgp
         T4cY0Dzm/PwnYaIHmf+PwUzlfqOZTg7x/igR+pvsOArjEi6B4KY1Or/wIIcsjsU8Bj
         pgI09V1Lvon1d87g1orGpQx3tokCeXI4IAWTg2GjU2ZHnJ5QI2Z11ijQ+Dr/azxLBs
         FDSR2c47Z8P5w==
Message-ID: <25b2f045e39fc40862c88d4af7081e4bbc0e3c92.camel@codeconstruct.com.au>
Subject: Re: [PATCH 10/10] ipmi: kcs_bmc: Add subsystem kerneldoc
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, aladyshev22@gmail.com,
        jk@codeconstruct.com.au
Date:   Mon, 06 Nov 2023 10:35:05 +1030
In-Reply-To: <20231103151230.0000161e@Huawei.com>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
         <20231103061522.1268637-11-andrew@codeconstruct.com.au>
         <20231103151230.0000161e@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-03 at 15:12 +0000, Jonathan Cameron wrote:
> On Fri,  3 Nov 2023 16:45:22 +1030
> Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>=20
> > Provide kerneldoc describing the relationships between and the
> > behaviours of the structures and functions of the KCS subsystem.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Seems reasonable but I've only a superficial idea of how this all fits
> together so no tag from me.

Thanks for the reviews so far!

>=20
> There is the fun question of whether function documentation should be
> next to the implementation or in the header.  As long as it's
> consistent in a given subsystem I don't personally thing it matters
> that much.

Happy to put it where people prefer. I like the consistency of having
it all in the one spot, but I appreciate the idea that it might be
easier to maintain alongside the implementation.

Andrew
