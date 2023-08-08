Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71709774071
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjHHRDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjHHRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:02:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685C161B1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D05F62454
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EC1C433C9;
        Tue,  8 Aug 2023 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691484871;
        bh=rcQ+guiUnFaf92cphgXAFZ0OeKKCTm2DZLiVcW5w29I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQst+NJ3jsnhEHBwpTX+sZGVYKhfkT9F43sCb6TKU8GVjtC9c4C0gkoFHD9Sl5p9s
         R09brzdWx/rKBg2eZFEvxo31C7TcpVBvlC2Vl+EqahVc/q3XJKCiGW7YjHW81I5T70
         rIE8TiSfaTMl2EH9BAcKm2lCNSMTkxuwpI1s1eNg=
Date:   Tue, 8 Aug 2023 10:54:19 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] PECI changes for v6.6-rc1
Message-ID: <2023080812-grappling-renegade-db16@gregkh>
References: <8a519c13e54deeb81fb07c8f2d3936e493820330.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a519c13e54deeb81fb07c8f2d3936e493820330.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:14:07PM +0000, Winiarska, Iwona wrote:
> Hi Greg!
> 
> Please pull PECI update for Linux v6.6.
> 
> Thanks
> -Iwona
> 
> The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:
> 
>   Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux.git tags/peci-next-6.6-rc1

Pulled and pushed out, thanks.

greg k-h
