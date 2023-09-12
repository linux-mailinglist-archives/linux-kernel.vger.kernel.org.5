Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6934879D570
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjILP6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:58:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9646D10DE;
        Tue, 12 Sep 2023 08:58:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35FEC433C7;
        Tue, 12 Sep 2023 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694534283;
        bh=W25BEEGerwOTf/J7Thrt0eHJlBpjW1DTVZWcJFBtBFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QI91A9yQeV7B2QdHq2e+5HwP5jS+fD7SJz20BmvT2TQXUhYYGFyEf9gA0HRaZ+1UE
         d+OejMSWvCw9WQxsre/kZzndiDUZg8n9C1puLqWC5CNSYMy5RNPFR8XGUGRuJtv2Kz
         pQLxbXtEIrecy6uPgkAooT2BQLI1AZ7Awz1+Dr3WCyJiyJx8DcY6NrYT1qu3MM8762
         EoSUVWaroRUWW+hI72+DhPk17sl8cxuzv9EQzV9Xr7PNfLT+wDNQ0kh4r2G5Ccwa1X
         JMQ6HpVTEJ/UluKi1tRS5sXOEvDa89oi8uPjUJEflCSjA9yLj8g7eFH9dmIwCJARWA
         C63xoSk9EiTEQ==
Received: (nullmailer pid 859269 invoked by uid 1000);
        Tue, 12 Sep 2023 15:58:00 -0000
Date:   Tue, 12 Sep 2023 10:58:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [RFC v1 1/3] dt-bindings: thermal: mediatek: add mt7988
 compatible
Message-ID: <169453428010.859206.8089094622420685827.robh@kernel.org>
References: <20230911183354.11487-1-linux@fw-web.de>
 <20230911183354.11487-2-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911183354.11487-2-linux@fw-web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Sep 2023 20:33:52 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string for mt7988.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../devicetree/bindings/thermal/mediatek,lvts-thermal.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

