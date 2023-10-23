Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9482E7D388A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjJWN4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjJWN4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:56:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7681B101;
        Mon, 23 Oct 2023 06:55:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5364C433C7;
        Mon, 23 Oct 2023 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698069359;
        bh=yY7128FTqOAVEE2hwQAdyTNyFxh3eCY8SsAjx1SS6aE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fBvOzI0O488r6TEi17oJjyAQmZ+UR9Py5FcB5n2vajr/gcaOPqaxX7qOFksLV/V85
         fjasd82I7K2qyP75iUh7EKUbGHwulm98UKkphZ6c94ELbK9yA5YiME5YrzfGBQF/+F
         Cz1GDZp+6Th28B30W3mgjG5vkXUb7Yuy745dt+HRpo0Yy9V37VPp3xvKe9Q7Gmi9a2
         uRRaMITaExe2MiCG17jVmwO0i5+v/qKmln6uyK8YPL0zRRYsrKQfrQUP7sxV74epRg
         IWbs3ZeeM4TUxsfAheQnxbzSm9XV66xgbviHlVZ1WfRn5Y37XsMprB3jfir84NrQKN
         pD9AppS8dfAKA==
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
In-Reply-To: <20231023131409.1796451-1-sebastian.reichel@collabora.com>
References: <20231023131409.1796451-1-sebastian.reichel@collabora.com>
Subject: Re: (subset) [PATCH v4] dt-bindings: mfd: max8925: Convert to DT
 schema format
Message-Id: <169806935666.159408.10545089566212045567.b4-ty@kernel.org>
Date:   Mon, 23 Oct 2023 14:55:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 15:12:20 +0200, Sebastian Reichel wrote:
> Convert the binding to DT schema format.
> 
> The sub-functions of this MFD device do not have their own compatible
> string and are thus described directly in the MFD binding document
> after being converted to YAML.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: max8925: Convert to DT schema format
      commit: 34abc0252d1923cdf82c2352409df490253c8814

--
Lee Jones [李琼斯]

