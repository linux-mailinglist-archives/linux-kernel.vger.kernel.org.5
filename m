Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDC67EC129
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343580AbjKOLSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbjKOLSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:18:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49168E6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:18:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D52FC433C8;
        Wed, 15 Nov 2023 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700047118;
        bh=adpWzHaP7Je7KyP6sEwKyhUso8uKwhw/i89rIOpi9f0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UIDlGeKt7KzPNrV/vXmhP4BC/5bibGM6S61HotM5q0DKZW2lENcVH1ybP1yfHh5kx
         3nT0mYSPFvgl4YSZ8tB504dqvp+DEvYI1fzRSkFkpO+NUIE/6ex6StXAeeCOPk2eha
         po6p4kXeSIkggwkZr+AqErf45Bdyh5n5GB3rXgBMyHfr+bfJdD9g+n22/Rw09S9Ijg
         Y0VzjsHCqR0uIAONUZjgiiGLyWBM1Z5YEGT6pfW4NlmI8WLi89dLZpq7CQXtesqmEn
         eBn2jg6inCxclDzo6FUEQdzkSdo2fZSZ4ao5KSdQAx3o1fupT5/IfxFQ0CzwbbnhtZ
         i5cyQsh/OnxvA==
Message-ID: <495a61b9-7208-472b-aec4-411a034ea34a@kernel.org>
Date:   Wed, 15 Nov 2023 13:18:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add entry for TI ICSSG Ethernet driver
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
        Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com
References: <20231113094656.3939317-1-danishanwar@ti.com>
 <20231114175013.3ab9b056@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231114175013.3ab9b056@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/11/2023 00:50, Jakub Kicinski wrote:
> On Mon, 13 Nov 2023 15:16:56 +0530 MD Danish Anwar wrote:
>> Also add Roger and myself as maintainer.
> 
>> +TI ICSSG ETHERNET DRIVER (ICSSG)
>> +R:	MD Danish Anwar <danishanwar@ti.com>
>> +R:	Roger Quadros <rogerq@kernel.org>
> 
> Looks like this got (silently?) merged already, but you added
> yourselves as R:eviewers not M:aintainers..

Reviewer is correct for me.

-- 
cheers,
-roger
