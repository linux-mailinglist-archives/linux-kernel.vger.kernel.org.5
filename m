Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F779F03C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjIMRRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjIMRRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:17:05 -0400
Received: from smtp103.ord1d.emailsrvr.com (smtp103.ord1d.emailsrvr.com [184.106.54.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC7319BF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694625420;
        bh=UOW47xYUGHtb0y7U9LBDecTV4C+XErNAhEpfAe+rLT0=;
        h=Date:Subject:To:From:From;
        b=o6c4OsuN/qrrv2XpxfQYRzqqvzVqqsFjXhwrXKnzU14ywMn65rkHMOmqwbw3fbWja
         EQgKcHJ93UGBwFEJ4H7gH5O65E9Ggg200vs5YYsLz+q1Bai4CtSz6rbc3e79HWs2g8
         ytlC0L+nGZ+Fl01Sw9EYI5ZTr9FByVmhnb8UBZnk=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp21.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 83EE760158;
        Wed, 13 Sep 2023 13:16:59 -0400 (EDT)
Message-ID: <246cccf6-7e51-4b6a-b09b-5803c4f63872@mev.co.uk>
Date:   Wed, 13 Sep 2023 18:16:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] comedi: Re-do HAS_IOPORT dependencies
Content-Language: en-GB
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
 <20230913164013.107520-1-abbotti@mev.co.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20230913164013.107520-1-abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 83e048ce-baa0-47b8-8373-670e9b19ed90-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 17:40, Ian Abbott wrote:
> v2:
> 
> 0. Patch titles and numbering is unchanged since v1.
> 
> 1. Corrects [CONFIG_]HAS_PORTIO to [CONFIG_]HAS_IOPORT in the code for
> patches 05 and 08, and in the description for patches 05, 06, 08, 10,
> 11, and 12.
> 
> 2. Enhances the commit description for patch 08 a bit.

Superceded by v3.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

