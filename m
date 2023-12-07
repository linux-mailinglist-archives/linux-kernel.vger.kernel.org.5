Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC268081A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377774AbjLGHLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjLGHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:11:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C7E1735
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:11:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2952EC433C7;
        Thu,  7 Dec 2023 07:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701933062;
        bh=71XowMO1zokcNUVSjk7xgSIelzcj/5YLVU2L9lqlOek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIE61cPk1suFhoEEtmSEKqDL3oRt5v1fozcF1+3dkUah52fb1aTBg3lMYugNifZu6
         DSE+OKcVM3mvSSVLZlNV1kg/1SXiemnrQQXMBE/Bm9xQ8CRTJG4I2mR57zgk4rrIuq
         mItlLbjuyor+w/iZ8mX/+DVlYGma7Nmi1cg8p178=
Date:   Thu, 7 Dec 2023 08:10:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, Roy Luo <royluo@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] usb: core: add phy notify connect and disconnect
Message-ID: <2023120724-herring-filled-c32e@gregkh>
References: <20231110054738.23515-1-stanley_chang@realtek.com>
 <20231110054738.23515-4-stanley_chang@realtek.com>
 <4736a6933f3546c48f24a635c15a5e20@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4736a6933f3546c48f24a635c15a5e20@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 04:50:10AM +0000, Stanley Chang[昌育德] wrote:
> Hi Greg,
> 
> Please help review this patch.

This series is gone from my tree as others reviewed it and asked for
changes.  If you think those changes are not needed, feel free to resend
it with an explanation of why that is so.

thanks,

greg k-h
