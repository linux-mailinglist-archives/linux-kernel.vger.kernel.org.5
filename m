Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C43F7BA326
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjJEPwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjJEPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:50:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B8F7128E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:10:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58016C43397;
        Thu,  5 Oct 2023 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696515058;
        bh=Nkfk7MhTCq1evvXnrxFdjG9h3hwdDUiWJIR4L5Vl+hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Py3bNk4QzT3h/rrknp2nuLWVDStLYQKZXxwP/wC9su1vcHkeaq+9DWb3s5pOgz6Xx
         JnPkj4telbfvWqzpx5Kw/leCgy8Hh8qls78oihiBhxSgzmjQx67xSuU+hMATcRCyST
         gjsScDBBSgzXCJM51ahy5b+JlFJSVDBULiHzAbpE=
Date:   Thu, 5 Oct 2023 16:10:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>
Cc:     "Simek, Michal" <michal.simek@amd.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "Manne, Nava kishore" <nava.kishore.manne@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "Shaikh, Izhar Ameer" <izhar.ameer.shaikh@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Kannan, Arun Balaji" <arun.balaji.kannan@amd.com>
Subject: Re: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of event
 manager driver
Message-ID: <2023100528-dubbed-parole-0544@gregkh>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-7-jay.buddhabhatti@amd.com>
 <2023100446-jokester-uncrushed-c9b2@gregkh>
 <48bc9520-fd5f-43fc-9adf-2a9e0493109a@amd.com>
 <2023100444-dose-laziness-d488@gregkh>
 <d4ee1dc7-d642-4cbc-a2a6-200cd1fcc96f@amd.com>
 <DM6PR12MB4465D25826A74C22B3FC4C1F9DCAA@DM6PR12MB4465.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4465D25826A74C22B3FC4C1F9DCAA@DM6PR12MB4465.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 02:09:39PM +0000, Buddhabhatti, Jay wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Simek, Michal <michal.simek@amd.com>
> > Sent: Wednesday, October 4, 2023 8:05 PM
> > To: Greg KH <gregkh@linuxfoundation.org>
> > Cc: Buddhabhatti, Jay <jay.buddhabhatti@amd.com>; Shah, Tanmay
> > <tanmay.shah@amd.com>; Manne, Nava kishore
> > <nava.kishore.manne@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>;
> > robh@kernel.org; dhaval.r.shah@amd.com; marex@denx.de; Shaikh, Izhar
> > Ameer <izhar.ameer.shaikh@amd.com>; arnd@arndb.de;
> > ruanjinjie@huawei.com; mathieu.poirier@linaro.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of event
> > manager driver
> > 
> > 
> > 
> > On 10/4/23 15:47, Greg KH wrote:
> > > On Wed, Oct 04, 2023 at 03:16:15PM +0200, Michal Simek wrote:
> > >>
> > >>
> > >> On 10/4/23 14:17, Greg KH wrote:
> > >>> On Wed, Oct 04, 2023 at 02:41:16AM -0700, Jay Buddhabhatti wrote:
> > >>>> Added Michal as a maintainer of event manager driver as Abhyuday is
> > >>>> no longer in AMD-Xilinx.
> > >>>>
> > >>>> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> > >>>> Acked-by: Michal Simek <michal.simek@amd.com>
> > >>>> ---
> > >>>>    MAINTAINERS | 2 +-
> > >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/MAINTAINERS b/MAINTAINERS index
> > >>>> 35977b269d5e..f36fefd7032b 100644
> > >>>> --- a/MAINTAINERS
> > >>>> +++ b/MAINTAINERS
> > >>>> @@ -23672,7 +23672,7 @@ F:
> > 	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> > >>>>    F:	drivers/net/can/xilinx_can.c
> > >>>>    XILINX EVENT MANAGEMENT DRIVER
> > >>>> -M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > >>>> +M:	Michal Simek <michal.simek@amd.com>
> > >>>
> > >>> For obvious reasons, we need an ack from Abhyuday.
> > >>
> > >> He no longer works for Xilinx/AMD but I have asked him on side
> > >> channel to reply and let's see if this is going to happen or not.
> > >
> > > Mantainerships follow people, not companies, so if he wants to keep
> > > being the maintainer, he can be, there's no requirement for him to
> > > step down.
> > 
> > No doubt about it but normally in these cases people send a patch to start to
> > use their new email address which is what didn't happen for quite a long time
> > in this case.
> > I am definitely happy to wait some time if he reacts but if there is no reaction
> > for some time we should fix it.
> 
> [Jay] I got information that Abhyuday is aware about this, but he is not going to react on it.

So I guess they want to remain the maintainer?  That's fine, but a new
email address for them is probably wanted if this one currently bounces.

thanks,

greg k-h
