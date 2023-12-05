Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9014804546
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346317AbjLECpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjLECow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:44:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9041702
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:44:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD52CC433C8;
        Tue,  5 Dec 2023 02:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701744268;
        bh=IHTeEY6xAwIklEypulw2bMOeouKK1Rphc7/TbH7wzjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L+3cvUXi92VN8yr3PVhH+xnN4oAJN9W1P5SBBLr81mSNhXPdTxlnAVZq5+ZaG4uEr
         vJxV9VsTDXVMpPx/HPOfckNGkPWxPrZ2HswUtVOSR+bz6WQmhE7Y1fxsnEVxhCRjwE
         CTKdPfw1cX4IyUBaRGjq0/sNaTSsrx5ISbSmV7UL9rZHHh/5PdOAwAQNpmZ8VzDuiD
         0IkBT/RWvzjuCJQqFEeyW7CGQskv1ShnovKHL8NzFj6cYGYHyEbpL08zO4d1sBMfwx
         cLR+B8lZdRf3dTKOt5zJn49Qsfrg6w9FIfsrbsv7A8fQ6HlZWVeT6tUjD8jp2A0BQp
         NRy+R58QsDD7Q==
Date:   Mon, 4 Dec 2023 18:44:26 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v6 4/6] ptp: clockmatrix: dco input-to-output
 delay is 20 FOD cycles + 8ns
Message-ID: <20231204184426.41b99c37@kernel.org>
In-Reply-To: <PH7PR03MB7064A9C11FB1252AEED5EF13A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
References: <20231130184634.22577-1-lnimi@hotmail.com>
        <PH7PR03MB7064A9C11FB1252AEED5EF13A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 13:46:32 -0500 Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>

This one is missing a commit message.
-- 
pw-bot: cr
