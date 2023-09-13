Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E09579F00F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjIMRPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjIMRPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:15:10 -0400
Received: from smtp93.ord1d.emailsrvr.com (smtp93.ord1d.emailsrvr.com [184.106.54.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727A1BEC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694625305;
        bh=k6EppX5Ox23HhmjmCO06GwNEiXA+oHz9lsjGFjqxGJM=;
        h=Date:Subject:To:From:From;
        b=gFARytaymgZdJh5o28+hKJM7UcNelZrlG37enk4TXkC1WjCAZ6KpdwfNBAF5yjztT
         bGe1MfUP8ue7/O5eVf3OVRqrmcF2nEa7zKlrXWQEPnd8YAemGKvezwa5JG9HNUYVmR
         bXIIJ1XYoU2YVStkg3o9VzsR7ZUyBIxfAyciRg0o=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id EDB18C016D;
        Wed, 13 Sep 2023 13:15:04 -0400 (EDT)
Message-ID: <6fab5e87-244e-42e3-81f2-d7651efe78f7@mev.co.uk>
Date:   Wed, 13 Sep 2023 18:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] comedi: Re-do HAS_IOPORT dependencies
Content-Language: en-GB
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <20230913164013.107520-1-abbotti@mev.co.uk>
 <20230913170712.111719-1-abbotti@mev.co.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20230913170712.111719-1-abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 96f14954-9728-44db-beae-40f93d3e7431-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 18:06, Ian Abbott wrote:
> v3:
> 
> 0. Patch titles and numbering is unchanged since v2.
> 
> 1. Adds missing `---` divider lines before patch changelogs for patches
> 06 and 09.

^ That should read "for patches 04, 06 and 09".  It doesn't affect any 
commits though (for once!).

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

