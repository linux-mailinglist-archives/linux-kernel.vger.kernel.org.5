Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194E576EC1E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbjHCOPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjHCOOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:14:50 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F06421E;
        Thu,  3 Aug 2023 07:14:16 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 07876206B8;
        Thu,  3 Aug 2023 16:14:13 +0200 (CEST)
Date:   Thu, 3 Aug 2023 16:14:08 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v3 2/8] arm64: dts: ti: k3-am62-main: Add node for DSS
Message-ID: <ZMu2MMGCXzBu7wf2@francesco-nb.int.toradex.com>
References: <20230728173438.12995-1-a-bhatia1@ti.com>
 <20230728173438.12995-3-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728173438.12995-3-a-bhatia1@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Aradhya, Nishanth and Vignesh

On Fri, Jul 28, 2023 at 11:04:32PM +0530, Aradhya Bhatia wrote:
> Add Display SubSystem (DSS) DT node for the AM625 SoC.
> 
> The DSS supports one each of video pipeline (vid) and video-lite
> pipeline (vidl1). It outputs OLDI signals on one video port (VP1) and
> DPI signals on another (VP2). The video ports are connected to the
> pipelines via 2 identical overlay managers (ovr1 and ovr2).

Not sure on the plan on the whole series, but from my point of view it
would make sense to have (at least) this patch, if deemed correctly,
applied for v6.6.

This will enable others TI AM625 user to start upstreaming their changes
and testing it.

Francesco

