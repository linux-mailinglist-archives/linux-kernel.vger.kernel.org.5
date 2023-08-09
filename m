Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3E477564F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjHIJ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjHIJ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:26:51 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DAA219BC;
        Wed,  9 Aug 2023 02:26:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 448E68105;
        Wed,  9 Aug 2023 09:26:49 +0000 (UTC)
Date:   Wed, 9 Aug 2023 12:26:48 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] bus: ti-sysc: Build driver for TI K3 SoCs
Message-ID: <20230809092648.GE11676@atomide.com>
References: <20230804103859.57458-1-tony@atomide.com>
 <20230804103859.57458-2-tony@atomide.com>
 <20230805052052.zjamrxarn6uc4i5l@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805052052.zjamrxarn6uc4i5l@dhruva>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dhruva Gole <d-gole@ti.com> [230805 05:20]:
> On Aug 04, 2023 at 13:38:58 +0300, Tony Lindgren wrote:
> > Allow building ti-sysc also for K3 SoCs. This allows configuring the wkup
> > domain devices for SYSCONFIG register wake-up events in a generic way.
> 
> If possible, can we add explanation also on why it now needs to be default y
> in the Kconfig?

Sure will add that for v2.

Thanks,

Tony
