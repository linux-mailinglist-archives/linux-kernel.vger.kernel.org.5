Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E1A76EC09
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjHCOMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjHCOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:12:14 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233E0E69;
        Thu,  3 Aug 2023 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691071898; x=1722607898;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F8f4BApASGNCPhtinYIc3rUiCeFOT3UfB6SVX2g7axo=;
  b=VufsGXUQQSWExSdAEUVDXfVX0xlGilrCTarxQODqfseYbYO25a69g3Mp
   6OnWbTDC7Erbc5ZxRNdY6uToE/y0EVKaCe1pWkAdLk949DyoIoLHPtWma
   +4lwR7QF2dReeFojFwhzos/Kf1oWEv26WfIKUjdR22VjQ3kGqTbngs2Es
   hAOUsxipYbkyiDFpUOCMM0Tvc/eE7fgB19p8rfhQewmDeV69eQn6L4PWc
   Cmt131VQRWIK8u2YTelWgComBpvks2fwGNCKhZL1H+ZeCcymPtWUJQ/eB
   uKs5U/YWNgJmjajbdXi4YGQMLF343+x1DScpef5QtAcbHs7DFwl//8k+b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373517225"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="373517225"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 06:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="819656692"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="819656692"
Received: from eozturk-mobl.ger.corp.intel.com ([10.249.38.219])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 06:39:11 -0700
Date:   Thu, 3 Aug 2023 16:39:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update TTY layer for lists and recently
 added files
In-Reply-To: <20230802120530.GE14799@atomide.com>
Message-ID: <61e5675-570-9566-34c2-86975c56d961@linux.intel.com>
References: <20230721072334.59272-1-tony@atomide.com> <ZLpboaXKVOOjeGJ+@smile.fi.intel.com> <20230724045327.GV5194@atomide.com> <2023072517-onward-payment-569d@gregkh> <2023072530-wired-chaps-c1e3@gregkh> <edb0414f-3808-8651-4956-8ec34b056901@kernel.org>
 <20230802120530.GE14799@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-294453060-1691069953=:1954"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-294453060-1691069953=:1954
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 2 Aug 2023, Tony Lindgren wrote:

> * Jiri Slaby <jirislaby@kernel.org> [230726 10:12]:
> > On 25. 07. 23, 19:29, Greg Kroah-Hartman wrote:
> > > On Tue, Jul 25, 2023 at 07:28:46PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Jul 24, 2023 at 07:53:27AM +0300, Tony Lindgren wrote:
> > > > > * Andy Shevchenko <andriy.shevchenko@intel.com> [230721 10:19]:
> > > > > > On Fri, Jul 21, 2023 at 10:23:32AM +0300, Tony Lindgren wrote:
> > > > > > > Add mailing lists for linux-serial and lkml for the TTY layer. And let's
> > > > > > > list the recently added files. This makes it easier for get_maintainer.pl
> > > > > > > to include linux-serial for patches.
> > > > > > 
> > > > > > Shouldn't serial_* stuff go to the "SERIAL DRIVERS" section?
> > > > > 
> > > > > Not sure if there's some reason we have "TTY LAYER" with serial_core
> > > > > files. If not, yeah let's move the serial files.
> > > > 
> > > > I'll take this patch, can you send a new one that removes the serial
> > > > files from this entry as I don't think they are needed in here anymore.
> > > 
> > > Better yet, they should be merged probably.  Although I don't know if
> > > Jiri wants to be responsible for serial stuff, that's his call...
> > 
> > No problem. I actually didn't realize they are separate. So feel free to
> > submit a patch, so we have a single MAINTAINTERS file entry...
> 
> How about something like this?
> 
> Tony
> 
> 8< ----------------------
> diff --git a/MAINTAINERS b/MAINTAINERS
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19319,13 +19319,6 @@ F:	Documentation/devicetree/bindings/serial/serial.yaml
>  F:	drivers/tty/serdev/
>  F:	include/linux/serdev.h
>  
> -SERIAL DRIVERS
> -M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> -L:	linux-serial@vger.kernel.org
> -S:	Maintained
> -F:	Documentation/devicetree/bindings/serial/
> -F:	drivers/tty/serial/
> -
>  SERIAL IR RECEIVER
>  M:	Sean Young <sean@mess.org>
>  L:	linux-media@vger.kernel.org
> @@ -21760,20 +21753,16 @@ W:	https://github.com/srcres258/linux-doc
>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>  F:	Documentation/translations/zh_TW/
>  
> -TTY LAYER
> +TTY LAYER AND SERIAL DRIVERS
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Jiri Slaby <jirislaby@kernel.org>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-serial@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> +F:	Documentation/devicetree/bindings/serial/
>  F:	Documentation/driver-api/serial/
>  F:	drivers/tty/
> -F:	drivers/tty/serial/serial_base.h
> -F:	drivers/tty/serial/serial_base_bus.c
> -F:	drivers/tty/serial/serial_core.c
> -F:	drivers/tty/serial/serial_ctrl.c
> -F:	drivers/tty/serial/serial_port.c
>  F:	include/linux/selection.h
>  F:	include/linux/serial.h
>  F:	include/linux/serial_core.h

The separation of these two has always felt a bit artificial to me.

Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-294453060-1691069953=:1954--
