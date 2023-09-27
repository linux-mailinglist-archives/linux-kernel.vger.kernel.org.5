Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EB97AFA2B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjI0Fhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjI0FhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:37:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74F45900B;
        Tue, 26 Sep 2023 21:30:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E711180A3;
        Wed, 27 Sep 2023 04:30:51 +0000 (UTC)
Date:   Wed, 27 Sep 2023 07:30:50 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Thomas Richard <thomas.richard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] serial: 8250_omap: Fix errors with no_console_suspend
Message-ID: <20230927043050.GC5285@atomide.com>
References: <20230926061319.15140-1-tony@atomide.com>
 <652eb018-8e67-5f4b-8329-0f52159a27b1@bootlin.com>
 <20230926113241.ws2tco3poeixhupi@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926113241.ws2tco3poeixhupi@dhruva>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dhruva Gole <d-gole@ti.com> [230926 11:32]:
> Don't we want a closes: tag?

Seems it should only be used if there's some bugzilla type report and
not for email threads.

Regards,

Tony
