Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96A7770D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjHJHAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjHJHA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:00:28 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFFC7AC;
        Thu, 10 Aug 2023 00:00:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 663A080A9;
        Thu, 10 Aug 2023 07:00:26 +0000 (UTC)
Date:   Thu, 10 Aug 2023 10:00:25 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] serial: core: Revert port_id use
Message-ID: <20230810070025.GJ11676@atomide.com>
References: <20230806062052.47737-1-tony@atomide.com>
 <b8829d4b-d221-49ce-b0cd-e82dc79be719@roeck-us.net>
 <20230809052650.GT14799@atomide.com>
 <d883dd8b-1858-7204-32f6-09f1ef9ec326@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d883dd8b-1858-7204-32f6-09f1ef9ec326@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [230809 21:17]:
> On 8/8/23 22:26, Tony Lindgren wrote:
> > Guenter, care to also test the patch below on top of this fix and
> > see if things still behave for you?
> > 
> > I'll send a proper patch assuming things test fine.
> > 
> 
> Patch below works for me.

OK good to hear thanks, patch posted at [0] below.

Regards,

Tony

[0] https://lore.kernel.org/linux-serial/20230810065737.47294-1-tony@atomide.com/T/#u
