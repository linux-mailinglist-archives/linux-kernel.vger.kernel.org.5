Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27291771A77
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjHGGeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjHGGeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:34:44 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74C761711;
        Sun,  6 Aug 2023 23:34:41 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(3962136:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 07 Aug 2023 14:34:31 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 7 Aug
 2023 14:34:31 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 7 Aug 2023 14:34:31 +0800
Date:   Mon, 7 Aug 2023 14:34:31 +0800
From:   Alina Yu <alina_yu@richtek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     ChiYuan Huang <cy_huang@richtek.com>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <alina_yu@richtek.com>
Subject: Re: [PATCH v5 2/2] regulator: rtq2208: Add Richtek RTQ2208 SubPMIC
 driver
Message-ID: <20230807063431.GA31530@linuxcarl2.richtek.com>
References: <1690355592-10920-1-git-send-email-alina_yu@richtek.com>
 <1690355592-10920-3-git-send-email-alina_yu@richtek.com>
 <20230803072425.GA22780@linuxcarl2.richtek.com>
 <e31b8381-7148-4485-834a-02638e9a81d7@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e31b8381-7148-4485-834a-02638e9a81d7@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Mark,

On Thu, Aug 03, 2023 at 12:08:28PM +0100, Mark Brown wrote:
> On Thu, Aug 03, 2023 at 03:24:25PM +0800, ChiYuan Huang wrote:
> > On Wed, Jul 26, 2023 at 03:13:12PM +0800, Alina Yu wrote:
> 
> > > Signed-off-by: Alina Yu <alina_yu@richtek.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > This patch series is to add new drivers, not fix.
> > Why do you add the Reported-by tag?
> 
> The LKP people have some boilerplate in their reports that tells people
> to add Reported-bys for things they find based on patches, it's a
> constant problem :(

Sorry, I misunerstood the meaning of Reported-by
I've removed that since v6.

Thanks, Alina

