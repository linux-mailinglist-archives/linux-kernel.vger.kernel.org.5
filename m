Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4047EF802
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjKQTrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjKQTrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:47:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E265D5C;
        Fri, 17 Nov 2023 11:46:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918F1C433C8;
        Fri, 17 Nov 2023 19:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700250417;
        bh=/LhMOYd/JOXNFZ07PxWcoviKMP3G1QFUwtsQ6l2wVJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkMpN941PQpk3SOyyqtZfzKBpP77UWi57lCmpqAk4s1DM0uhDfgWyvbzkSo1ii5PJ
         thwwYjHwv9sbP6v4nry2tDqhr93xGbxZJJLnD3Y9Hs7RUWCmuUI+lfExxPqH1jsc/p
         IRPZgIg2sIy58V3DU8KJ33Bnu9Or+fV1/FSt/v3g=
Date:   Fri, 17 Nov 2023 14:46:55 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Zubin Mithra <zsm@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: set the dma max_seg_size
Message-ID: <2023111754-expand-facsimile-febe@gregkh>
References: <20231026-dwc3-v2-1-1d4fd5c3e067@chromium.org>
 <20231031232227.xkk4ju3hxifj3vee@synopsys.com>
 <CANiDSCvEyjHFT3KQbsbURjUadpQYEfQ=M8esdcHnpWe9VsK=2w@mail.gmail.com>
 <20231110225507.cl6w6vkyb4dvj3uh@synopsys.com>
 <CANiDSCu1WdKu+2Erkj9iEnp21Cuk84MC_ow+8o-qETqJH1qMNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCu1WdKu+2Erkj9iEnp21Cuk84MC_ow+8o-qETqJH1qMNg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 01:48:47PM +0100, Ricardo Ribalda wrote:
> Greg: Friendly ping, just want to make sure that the patch did not
> fell into the cracks

The merge window just ended, and we have been away at the plumbers
conference all week long.  Give us a chance to travel back home and
start to catch up in the next few weeks.

In the meantime, please take some time and review the pending dwc3
patches on the list to make my review process easier and allow me to get
through them all to yours quicker.

thanks,

greg k-h
