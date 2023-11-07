Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684D37E4199
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjKGOLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKGOLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:11:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D00EA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:11:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CDDC433C7;
        Tue,  7 Nov 2023 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699366260;
        bh=2p0nrUpO0muiskZfeFQI+ja53nbp3CmszJSoIJKWGAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z9WodZKNQxI0vyw5sEhlHkwCCoIOKWNRtezB57cZ/GhUG0j+bq4pUmY/0JKVNL/i3
         dWIFcr5LPFynT/MXVjEdnoMaVhHkT1rj3F8jl+RM68GQqPJoou7EZ/eylZQq3HnALJ
         KdiMzMb4uow2T6fAFa6yiq+ad4KnyPN7aCYJhit8=
Date:   Tue, 7 Nov 2023 15:10:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Revert "mei/hdcp: Also enable for XE"
Message-ID: <2023110740-sensuous-sedation-dbd3@gregkh>
References: <20231107134606.316651-1-alexander.usyskin@intel.com>
 <20231107134606.316651-2-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107134606.316651-2-alexander.usyskin@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:46:02PM +0200, Alexander Usyskin wrote:
> This reverts commit 62db7d00efe48c614b006086f306d5addedf8f83.

That says what you did, but not why you did it, which means I can't take
this, sorry.

greg k-h
